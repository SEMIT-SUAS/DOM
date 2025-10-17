# DOM - Diário Oficial Municipal

Sistema web completo para gestão e publicação do Diário Oficial Municipal, desenvolvido com Hono framework e Cloudflare Pages.

## 🎯 Visão Geral

O DOM é uma plataforma moderna e responsiva para digitalização completa do processo de publicação do Diário Oficial Municipal, desde o envio de matérias pelas secretarias até a publicação oficial e pesquisa pública.

## 🌐 URLs do Sistema

- **Aplicação Web**: https://3000-iulmtf85zcwx4g6bfvptm-cc2fbc16.sandbox.novita.ai
- **API Health Check**: https://3000-iulmtf85zcwx4g6bfvptm-cc2fbc16.sandbox.novita.ai/api/health
- **Pesquisa Pública**: https://3000-iulmtf85zcwx4g6bfvptm-cc2fbc16.sandbox.novita.ai/pesquisa

## 👥 Credenciais de Teste

### Administrador
- **Email**: admin@municipio.gov.br
- **Senha**: admin123
- **Permissões**: Acesso total ao sistema

### SEMAD (Análise e Aprovação)
- **Email**: coordenador@semad.gov.br
- **Senha**: semad123
- **Permissões**: Análise, aprovação e rejeição de matérias

### Secretaria (Envio de Matérias)
- **Email**: joao.silva@semed.gov.br
- **Senha**: secretaria123
- **Permissões**: Criação e envio de matérias da SEMED

## ✨ Funcionalidades Implementadas (ATUALIZADO)

### ✅ Módulos Concluídos (MVP 85%)

#### 1. Sistema de Autenticação e Autorização
- Login com email e senha
- Geração de tokens JWT
- Controle de acesso por perfis (Admin, SEMAD, Secretaria, Público)
- Middleware de autenticação e autorização
- Hash SHA-256 para senhas
- Sistema de sessão persistente

#### 2. Módulo de Envio de Matérias (Secretarias) - CRUD COMPLETO E APRIMORADO
- **Interface de Criação/Edição Completa**:
  - Formulário completo para nova matéria
  - Editor de texto para conteúdo
  - **✅ SELECT de tipo de matéria** (Decreto, Lei, Portaria, Edital, etc.) - Tabela auxiliar implementada
  - **✅ Campo de prioridade** (Urgente, Alta, Normal, Baixa)
  - **✅ Data de publicação** (hoje ou datas futuras)
  - **✅ Campo de observações** (notas internas não publicadas)
  - Resumo opcional
  - Escolha de layout (1 ou 2 colunas)
  - Editar matérias em rascunho
  - **✅ Botão "Voltar"** em todos os formulários
  - Visualização prévia antes de enviar
  
- **Gestão de Matérias**:
  - Listagem de todas as matérias da secretaria
  - **✅ Filtros avançados**: busca por título, tipo, status e data
  - **✅ Botão "Limpar filtros"** para reset rápido
  - **✅ Badges de prioridade** visíveis na listagem
  - Visualização de status com cores
  - Visualização detalhada de cada matéria
  - Botões de ação contextuais por status
  
- **CRUD Completo**:
  - ✅ **Create**: Criar nova matéria
  - ✅ **Read**: Visualizar detalhes completos
  - ✅ **Update**: Editar rascunhos
  - ✅ **Delete**: Excluir rascunhos
  
- **Fluxo de Trabalho Completo**:
  - Salvar como rascunho (pode editar/excluir)
  - Enviar para análise SEMAD
  - **✅ Cancelar envio com motivo obrigatório** (volta para rascunho)
  - **✅ Controles de horário**: janelas de envio (até 15h e 18h-00h)
  - **✅ Bloqueio de finais de semana e feriados**
  - **✅ Registro de quem enviou e quando** (server timestamp)
  - Matérias enviadas: apenas visualizar ou cancelar
  - Controle de versões
  - Histórico de alterações

#### 3. Módulo de Análise e Aprovação (SEMAD) - INTERFACE COMPLETA
- **Fila de Análise**:
  - Lista de matérias pendentes com detalhes
  - Ordenação por data de envio
  - Status visual (Enviado, Em Análise)
  - Botão de ação "Analisar" direto
  
- **Tela de Revisão Completa**:
  - Visualização detalhada da matéria
  - Informações do autor e secretaria
  - Conteúdo completo com scroll
  - Campo para notas de revisão
  - Botões de Aprovar/Rejeitar destacados
  
- **Processo de Aprovação**:
  - Modal de aprovação com confirmação
  - Campo opcional para notas de revisão
  - Gerar assinatura eletrônica SHA-256
  - Exibir hash da assinatura
  - Notificar autor automaticamente
  - Feedback visual de sucesso
  
- **Processo de Rejeição**:
  - Prompt para motivo obrigatório
  - Validação de motivo preenchido
  - Devolver para rascunho
  - Notificar autor com justificativa
  - Feedback visual de rejeição
  
- **Lista de Aprovadas**:
  - Visualizar matérias aprovadas
  - Ver detalhes incluindo assinatura
  - Histórico completo

#### 4. Sistema de Assinatura Eletrônica
- Geração de hash SHA-256 da matéria
- Combinação: ID + usuário + conteúdo + timestamp
- Assinatura vinculada ao usuário SEMAD
- Registro de data/hora da assinatura
- Hash verificável para autenticidade

#### 5. Banco de Dados Completo
- **Tabelas Implementadas**:
  - `users` - Usuários do sistema
  - `secretarias` - Secretarias municipais
  - `categories` - Categorias de matérias
  - **✅ `matter_types`** - Tipos de matérias (tabela auxiliar para select)
  - `matters` - Matérias/publicações (com novos campos: priority, publication_date, observations, submitted_by, server_timestamp, cancelation_reason)
  - `matter_versions` - Histórico de versões
  - `attachments` - Anexos
  - `editions` - Edições do diário
  - `holidays` - Feriados
  - `publication_rules` - Regras de publicação
  - `notifications` - Notificações
  - `comments` - Comentários
  - `audit_logs` - Logs de auditoria
  - `system_settings` - Configurações

- **Dados Seed**:
  - 5 secretarias padrão
  - 8 categorias de matérias
  - **✅ 12 tipos de matérias pré-configurados** (Decreto, Lei, Portaria, Edital, Ato, Resolução, etc.)
  - 3 usuários de teste (senhas corrigidas com SHA-256)
  - Regras de publicação
  - Feriados nacionais 2025
  - Configurações do sistema

#### 6. Interface Web Responsiva - COMPLETA E APRIMORADA
- Design moderno com Tailwind CSS
- Adaptável para desktop, tablet e mobile
- Ícones FontAwesome integrados
- **✅ Navegação fixa no topo** (não esconde ao rolar)
- **Dashboard Real** com estatísticas:
  - Total de matérias
  - Contadores por status
  - Atividades recentes
  - Cards com ícones coloridos
- **Navegação Completa**:
  - Menu lateral intuitivo
  - Destaque do item ativo
  - Menus contextuais por perfil
  - **✅ Bug corrigido**: menus não persistem após logout
  - Navegação fluida entre telas
- **Feedback Visual**:
  - Status com cores (rascunho, enviado, aprovado, etc.)
  - **✅ Badges de prioridade** com cores (🔴 Urgente, 🟠 Alta, 🟢 Normal, 🔵 Baixa)
  - Botões de ação contextuais
  - Confirmações e alertas
  - Mensagens de sucesso/erro
- **Funcionalidades UX**:
  - Busca em tempo real
  - **✅ Filtros avançados** (texto, tipo, status, data)
  - **✅ Botão "Voltar"** em todas as telas de detalhes
  - **✅ Exibição de metadados completos**: tipo, prioridade, data de publicação, quem enviou, datador (server timestamp)
  - **✅ Exibição de observações internas** em destaque
  - **✅ Exibição de motivo de cancelamento** quando aplicável
  - Scroll em conteúdo longo
  - Tooltips informativos

## 🚧 Funcionalidades Pendentes

### ✅ Melhorias Recentemente Implementadas (2025-10-17)

1. **✅ Campo tipo como SELECT** - Migrado de input texto para dropdown com tabela auxiliar `matter_types`
2. **✅ Filtros avançados** - Filtros por data, tipo e status na listagem de matérias
3. **✅ Botões "Voltar"** - Adicionados em todos os formulários e telas de detalhes
4. **✅ Prompt para cancelamento** - Campo obrigatório para motivo ao cancelar envio
5. **✅ Prioridade de matérias** - Campo com 4 níveis (Urgente, Alta, Normal, Baixa)
6. **✅ Data de publicação** - Campo para agendar publicação futura
7. **✅ Campo observações** - Notas internas não publicadas
8. **✅ Registro de envio** - Captura de quem enviou e quando (datador/server timestamp)
9. **✅ Controles de horário** - Validação de janelas de envio (15h e 18h-00h)
10. **✅ Bloqueio de finais de semana e feriados** - Validação no backend
11. **✅ Exibição de metadados completos** - Tipo, prioridade, datas, submissor, observações
12. **✅ Navegação fixa** - Barra superior não esconde ao rolar
13. **✅ Bug de menus corrigido** - Menus não persistem após logout
14. **✅ Permissões ajustadas** - Admin e SEMAD podem criar matérias

### 📋 Próximas Implementações

#### 1. Módulo de Publicação
- Geração automática de edições
- Numeração sequencial
- Publicação agendada (cron)
- Publicação manual
- Status de edições

#### 2. Módulo de Pesquisa Pública
- Busca por texto completo
- Filtros avançados (data, categoria, secretaria)
- Visualização de matérias publicadas
- ⏳ Download de anexos (preparado, não implementado)
- Verificação de autenticidade (hash)

#### 3. Geração de PDF
- Template profissional
- Layout 1 coluna
- Layout 2 colunas
- Cabeçalho com brasão
- Numeração de páginas
- Índice por categoria
- Rodapé com data/horário

#### 4. Notificações por Email
- Matéria enviada → SEMAD
- Matéria aprovada → Secretaria
- Matéria rejeitada → Secretaria
- Publicação realizada → Todos
- Configuração SMTP

#### 5. Agendamento e Controle de Horário
- ✅ Horário limite para envio (cutoff) - 15h e janela 18h-00h (implementado no backend)
- Horário padrão de publicação
- ✅ Validação de dias úteis (implementado no backend)
- ✅ Respeito a feriados (implementado no backend)
- ⏳ Interface admin para configurar horários (pendente)
- Cron triggers Cloudflare

#### 6. Cadastro de Feriados
- ⏳ Interface de gerenciamento (preparado, não implementado)
- ✅ Tabela de feriados criada e populada (2025)
- ✅ Validação de feriados no envio (implementado no backend)
- Feriados recorrentes
- Pontos facultativos
- Importação de calendário

#### 7. Dashboard e Relatórios
- Estatísticas gerais
- Matérias por status
- Matérias por secretaria
- Tempo médio de aprovação
- Gráficos interativos
- Exportação de relatórios

#### 8. Administração
- ⏳ Gerenciamento de usuários (interface pendente)
- ⏳ Gerenciamento de secretarias (interface pendente)
- ⏳ Gerenciamento de categorias (interface pendente)
- ✅ **Gerenciamento de tipos de matérias** - CRUD via API implementado
- ⏳ Configurações do sistema (interface pendente)
- Backup e restauração
- ✅ Logs de auditoria (tabela criada e funcional)

## 🏗️ Arquitetura do Sistema

### Stack Tecnológica
- **Backend**: Hono Framework (TypeScript)
- **Frontend**: HTML5, JavaScript, Tailwind CSS
- **Banco de Dados**: Cloudflare D1 (SQLite distribuído)
- **Storage**: Cloudflare R2 (para PDFs futuros)
- **Runtime**: Cloudflare Workers
- **Deployment**: Cloudflare Pages

### Estrutura do Projeto
```
dom/
├── src/
│   ├── index.tsx              # Aplicação principal
│   ├── types/
│   │   └── index.ts           # Tipos TypeScript
│   ├── routes/
│   │   ├── auth.ts            # Rotas de autenticação
│   │   ├── matters.ts         # Rotas de matérias
│   │   └── semad.ts           # Rotas SEMAD
│   ├── middleware/
│   │   └── auth.ts            # Middleware de autenticação
│   └── utils/
│       ├── auth.ts            # Utilidades de autenticação
│       └── date.ts            # Utilidades de data
├── public/
│   └── static/
│       └── app.js             # JavaScript frontend
├── migrations/
│   └── 0001_initial_schema.sql
├── seed.sql
├── wrangler.jsonc
├── package.json
└── ecosystem.config.cjs
```

## 🚀 Como Executar

### Desenvolvimento Local

```bash
# Instalar dependências
npm install

# Aplicar migrações do banco
npm run db:migrate:local

# Popular banco com dados iniciais
npm run db:seed

# Build do projeto
npm run build

# Iniciar servidor de desenvolvimento
npm run dev:sandbox
# ou com PM2
pm2 start ecosystem.config.cjs
```

### Acessar o Sistema
1. Abra: http://localhost:3000
2. Faça login com uma das credenciais de teste
3. Explore as funcionalidades disponíveis

## 📊 Fluxo de Trabalho

### 1. Secretaria envia matéria
```
Rascunho → Enviar para Análise → Aguardando SEMAD
```

### 2. SEMAD analisa
```
Pendente → Em Análise → Aprovar/Rejeitar
```

### 3. Aprovação
```
Aprovado → Assinar Eletronicamente → Agendar Publicação → Publicar
```

### 4. Rejeição
```
Rejeitado (com motivo) → Devolver para Secretaria → Ajustar → Reenviar
```

## 🔐 Segurança

### Autenticação
- Hash SHA-256 para senhas
- Tokens JWT com expiração de 24h
- Validação de token em todas as rotas protegidas

### Autorização
- Controle por perfis (Role-Based Access Control)
- Verificação de permissões em cada endpoint
- Secretarias só acessam suas próprias matérias

### Assinatura Eletrônica
- Hash SHA-256: ID + Usuário + Conteúdo + Timestamp
- Vinculada ao usuário SEMAD
- Imutável após assinatura
- Rastreável e auditável

### Auditoria
- Log de todas as ações importantes
- Registro de IP e User-Agent
- Histórico de alterações (versões)
- Timestamp de todas as operações

## 📝 API Endpoints

### Autenticação
- `POST /api/auth/login` - Login
- `POST /api/auth/register` - Cadastro (admin)
- `POST /api/auth/change-password` - Alterar senha
- `GET /api/auth/me` - Dados do usuário

### Matérias
- `GET /api/matters` - Listar matérias (com filtros de visibilidade por role)
- `GET /api/matters/:id` - Buscar matéria
- `POST /api/matters` - Criar matéria (admin, semad e secretaria)
- `PUT /api/matters/:id` - Atualizar matéria
- `POST /api/matters/:id/submit` - Enviar para análise (com validações de horário/feriados)
- **✅ `POST /api/matters/:id/cancel`** - Cancelar envio com motivo

### Tipos de Matérias
- **✅ `GET /api/matter-types`** - Listar tipos de matérias
- **✅ `POST /api/matter-types`** - Criar tipo (admin only)
- **✅ `PUT /api/matter-types/:id`** - Atualizar tipo (admin only)

### SEMAD
- `GET /api/semad/pending` - Matérias pendentes
- `POST /api/semad/:id/review` - Iniciar análise
- `POST /api/semad/:id/approve` - Aprovar matéria
- `POST /api/semad/:id/reject` - Rejeitar matéria
- `POST /api/semad/:id/comment` - Adicionar comentário
- `GET /api/semad/dashboard` - Dashboard SEMAD

## 🎨 Perfis de Usuário

### Administrador
- Gerenciamento completo do sistema
- Acesso a todas as funcionalidades
- Gerenciamento de usuários
- Configurações do sistema

### SEMAD
- Análise e aprovação de matérias
- Assinatura eletrônica
- Agendamento de publicações
- Dashboard de gestão

### Secretaria
- Criação de matérias
- Envio para análise
- Acompanhamento de status
- Edição de rascunhos

### Público
- Pesquisa de publicações (futuro)
- Visualização de matérias publicadas (futuro)
- Download de PDFs (futuro)

## 📈 Status do Desenvolvimento

### MVP (Mínimo Produto Viável) - 85% Concluído
- ✅ Estrutura base
- ✅ Autenticação
- ✅ Envio de matérias (CRUD completo + melhorias)
- ✅ Análise SEMAD
- ✅ Assinatura eletrônica
- ✅ Controles de horário e feriados (backend)
- ✅ Sistema de tipos de matérias
- ✅ Filtros avançados
- ✅ Prioridades e agendamento
- ⏳ Publicação (60% - agendamento preparado)
- ⏳ Pesquisa pública

### Versão 2 - 0% Concluído
- ⏳ Geração de PDF
- ⏳ Notificações email
- ⏳ Dashboard completo
- ⏳ Relatórios

### Versão 3 - 0% Concluído
- ⏳ Agendamento automático
- ⏳ Feriados
- ⏳ Regras de publicação
- ⏳ Administração completa

## 🤝 Contribuindo

Este é um projeto em desenvolvimento ativo. Funcionalidades são adicionadas incrementalmente seguindo o documento de requisitos.

## 📄 Licença

Sistema desenvolvido para gestão pública municipal.

## 📞 Suporte

Para dúvidas ou sugestões sobre o sistema, consulte a documentação ou entre em contato com a equipe de desenvolvimento.

---

**Última Atualização**: 2025-10-17 20:30  
**Versão**: 0.8.5 (MVP 85% completo)  
**Status**: 🟢 Ativo e em desenvolvimento

## 📝 Changelog Recente

### v0.8.5 (2025-10-17)
- ✅ Implementado sistema de tipos de matérias com tabela auxiliar
- ✅ Adicionados filtros avançados (data, tipo, status)
- ✅ Implementado campo de prioridade com 4 níveis
- ✅ Adicionado campo de data de publicação
- ✅ Implementado campo de observações internas
- ✅ Adicionado registro de quem enviou e server timestamp
- ✅ Implementadas validações de horário de envio (15h e 18h-00h)
- ✅ Implementado bloqueio de finais de semana e feriados
- ✅ Implementado cancelamento com motivo obrigatório
- ✅ Corrigido bug de menus persistentes após logout
- ✅ Navegação superior fixada no topo
- ✅ Permissões ajustadas (admin/semad podem criar matérias)
- ✅ Melhorias na exibição de metadados completos
- ✅ API de tipos de matérias (CRUD completo)
