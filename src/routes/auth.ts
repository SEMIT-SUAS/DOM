// ====================================
// DOM - Authentication Routes
// ====================================

import { Hono } from 'hono';
import { HonoContext, User } from '../types';
import { hashPassword, verifyPassword, generateToken } from '../utils/auth';
import { getCurrentTimestamp } from '../utils/date';

const auth = new Hono<HonoContext>();

/**
 * POST /api/auth/login
 * Login de usuário
 */
auth.post('/login', async (c) => {
  try {
    const { email, password } = await c.req.json();
    
    if (!email || !password) {
      return c.json({ error: 'Email e senha são obrigatórios' }, 400);
    }
    
    // Buscar usuário por email
    const user = await c.env.DB
      .prepare('SELECT * FROM users WHERE email = ? AND active = 1')
      .bind(email)
      .first<User>();
    
    if (!user) {
      return c.json({ error: 'Credenciais inválidas' }, 401);
    }
    
    // Verificar senha
    const isValidPassword = await verifyPassword(password, user.password_hash);
    
    if (!isValidPassword) {
      return c.json({ error: 'Credenciais inválidas' }, 401);
    }
    
    // Atualizar último login
    await c.env.DB
      .prepare('UPDATE users SET last_login = datetime(\'now\') WHERE id = ?')
      .bind(user.id)
      .run();
    
    // Gerar token
    const token = await generateToken(user.id, user.email);
    
    // Buscar informações da secretaria se aplicável
    let secretaria = null;
    if (user.secretaria_id) {
      secretaria = await c.env.DB
        .prepare('SELECT id, name, acronym FROM secretarias WHERE id = ?')
        .bind(user.secretaria_id)
        .first();
    }
    
    // Remover senha do retorno
    const { password_hash, ...userWithoutPassword } = user;
    
    return c.json({
      token,
      user: {
        ...userWithoutPassword,
        secretaria
      }
    });
    
  } catch (error) {
    console.error('Login error:', error);
    return c.json({ error: 'Erro ao fazer login' }, 500);
  }
});

/**
 * POST /api/auth/register
 * Registro de novo usuário (apenas admin pode criar usuários)
 */
auth.post('/register', async (c) => {
  try {
    const { name, email, password, cpf, role, secretaria_id } = await c.req.json();
    
    if (!name || !email || !password || !role) {
      return c.json({ error: 'Dados obrigatórios faltando' }, 400);
    }
    
    // Validar role
    const validRoles = ['admin', 'semad', 'secretaria', 'publico'];
    if (!validRoles.includes(role)) {
      return c.json({ error: 'Role inválida' }, 400);
    }
    
    // Verificar se email já existe
    const existingUser = await c.env.DB
      .prepare('SELECT id FROM users WHERE email = ?')
      .bind(email)
      .first();
    
    if (existingUser) {
      return c.json({ error: 'Email já cadastrado' }, 400);
    }
    
    // Hash da senha
    const passwordHash = await hashPassword(password);
    
    // Inserir usuário
    const result = await c.env.DB
      .prepare(`
        INSERT INTO users (name, email, password_hash, cpf, role, secretaria_id, active, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, 1, datetime('now'), datetime('now'))
      `)
      .bind(name, email, passwordHash, cpf || null, role, secretaria_id || null)
      .run();
    
    return c.json({
      message: 'Usuário cadastrado com sucesso',
      userId: result.meta.last_row_id
    }, 201);
    
  } catch (error) {
    console.error('Register error:', error);
    return c.json({ error: 'Erro ao cadastrar usuário' }, 500);
  }
});

/**
 * POST /api/auth/change-password
 * Alterar senha do usuário autenticado
 */
auth.post('/change-password', async (c) => {
  try {
    const user = c.get('user');
    
    if (!user) {
      return c.json({ error: 'Usuário não autenticado' }, 401);
    }
    
    const { currentPassword, newPassword } = await c.req.json();
    
    if (!currentPassword || !newPassword) {
      return c.json({ error: 'Senhas são obrigatórias' }, 400);
    }
    
    if (newPassword.length < 6) {
      return c.json({ error: 'Nova senha deve ter pelo menos 6 caracteres' }, 400);
    }
    
    // Verificar senha atual
    const isValidPassword = await verifyPassword(currentPassword, user.password_hash);
    
    if (!isValidPassword) {
      return c.json({ error: 'Senha atual incorreta' }, 401);
    }
    
    // Hash da nova senha
    const newPasswordHash = await hashPassword(newPassword);
    
    // Atualizar senha
    await c.env.DB
      .prepare('UPDATE users SET password_hash = ?, updated_at = datetime(\'now\') WHERE id = ?')
      .bind(newPasswordHash, user.id)
      .run();
    
    return c.json({ message: 'Senha alterada com sucesso' });
    
  } catch (error) {
    console.error('Change password error:', error);
    return c.json({ error: 'Erro ao alterar senha' }, 500);
  }
});

/**
 * GET /api/auth/me
 * Retorna dados do usuário autenticado
 */
auth.get('/me', async (c) => {
  try {
    const user = c.get('user');
    
    if (!user) {
      return c.json({ error: 'Usuário não autenticado' }, 401);
    }
    
    // Buscar informações da secretaria se aplicável
    let secretaria = null;
    if (user.secretaria_id) {
      secretaria = await c.env.DB
        .prepare('SELECT id, name, acronym FROM secretarias WHERE id = ?')
        .bind(user.secretaria_id)
        .first();
    }
    
    // Remover senha do retorno
    const { password_hash, ...userWithoutPassword } = user;
    
    return c.json({
      ...userWithoutPassword,
      secretaria
    });
    
  } catch (error) {
    console.error('Get user error:', error);
    return c.json({ error: 'Erro ao buscar dados do usuário' }, 500);
  }
});

/**
 * POST /api/auth/forgot-password
 * Solicita redefinição de senha (simulado - sem email real)
 */
auth.post('/forgot-password', async (c) => {
  try {
    const { email } = await c.req.json();
    
    if (!email) {
      return c.json({ error: 'Email é obrigatório' }, 400);
    }
    
    // Buscar usuário
    const user = await c.env.DB
      .prepare('SELECT id, email, name FROM users WHERE email = ? AND active = 1')
      .bind(email)
      .first();
    
    // Por segurança, sempre retornar sucesso mesmo se email não existir
    // Em produção, enviaria email com token de reset
    
    if (user) {
      // TODO: Em produção, gerar token de reset e enviar email
      // Por enquanto, apenas registrar o log
      await c.env.DB
        .prepare(`
          INSERT INTO audit_logs (user_id, action, entity_type, entity_id, new_values, ip_address, user_agent, created_at)
          VALUES (?, ?, ?, ?, ?, ?, ?, datetime('now'))
        `)
        .bind(
          user.id,
          'forgot_password_request',
          'user',
          user.id,
          JSON.stringify({ email: user.email }),
          c.req.header('cf-connecting-ip') || 'unknown',
          c.req.header('user-agent') || 'unknown'
        )
        .run();
    }
    
    return c.json({ 
      message: 'Se o email existir em nossa base, você receberá instruções para redefinir sua senha.',
      // TEMPORÁRIO: Em desenvolvimento, retornar email de contato
      info: 'Em produção, um email será enviado. Entre em contato com o administrador do sistema.'
    });
    
  } catch (error) {
    console.error('Forgot password error:', error);
    return c.json({ error: 'Erro ao processar solicitação' }, 500);
  }
});

/**
 * POST /api/auth/reset-password
 * Redefine senha com token (placeholder para implementação futura)
 */
auth.post('/reset-password', async (c) => {
  try {
    const { token, newPassword } = await c.req.json();
    
    if (!token || !newPassword) {
      return c.json({ error: 'Token e nova senha são obrigatórios' }, 400);
    }
    
    if (newPassword.length < 6) {
      return c.json({ error: 'Nova senha deve ter pelo menos 6 caracteres' }, 400);
    }
    
    // TODO: Implementar validação de token e reset de senha
    // Por enquanto, retornar não implementado
    
    return c.json({ 
      error: 'Funcionalidade em desenvolvimento. Entre em contato com o administrador do sistema.' 
    }, 501);
    
  } catch (error) {
    console.error('Reset password error:', error);
    return c.json({ error: 'Erro ao redefinir senha' }, 500);
  }
});

export default auth;
