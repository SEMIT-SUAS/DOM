-- Migration 0005: System Settings
-- Tabela de configurações do sistema

CREATE TABLE IF NOT EXISTS system_settings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  category TEXT NOT NULL,
  key TEXT NOT NULL UNIQUE,
  value TEXT NOT NULL,
  value_type TEXT DEFAULT 'string' CHECK(value_type IN ('string', 'number', 'boolean', 'json')),
  description TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_by INTEGER,
  FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_settings_category ON system_settings(category);
CREATE INDEX IF NOT EXISTS idx_settings_key ON system_settings(key);

-- Configurações padrão
INSERT OR IGNORE INTO system_settings (category, key, value, value_type, description) VALUES
  -- Horários
  ('schedules', 'submission_deadline_hour', '15', 'number', 'Hora limite para envio de matérias (formato 24h)'),
  ('schedules', 'night_window_start', '18', 'number', 'Início da janela noturna (formato 24h)'),
  ('schedules', 'night_window_end', '23', 'number', 'Fim da janela noturna (formato 24h)'),
  ('schedules', 'allow_weekend_submission', 'false', 'boolean', 'Permitir envio em finais de semana'),
  
  -- Bloqueios
  ('restrictions', 'block_holidays', 'true', 'boolean', 'Bloquear envio em feriados'),
  ('restrictions', 'block_weekends', 'true', 'boolean', 'Bloquear envio em finais de semana'),
  ('restrictions', 'require_matter_approval', 'true', 'boolean', 'Exigir aprovação SEMAD para matérias'),
  
  -- Segurança
  ('security', 'session_timeout_hours', '24', 'number', 'Tempo de expiração da sessão (horas)'),
  ('security', 'require_strong_password', 'true', 'boolean', 'Exigir senha forte (min 8 caracteres)'),
  ('security', 'enable_audit_logging', 'true', 'boolean', 'Habilitar log de auditoria'),
  
  -- Edições
  ('editions', 'auto_increment_number', 'true', 'boolean', 'Numeração automática de edições'),
  ('editions', 'edition_number_format', '{number}/{year}', 'string', 'Formato da numeração (ex: 001/2025)'),
  ('editions', 'edition_number_padding', '3', 'number', 'Zeros à esquerda na numeração'),
  
  -- Branding
  ('branding', 'municipality_name', 'São Luís', 'string', 'Nome do município'),
  ('branding', 'municipality_uf', 'MA', 'string', 'UF do município'),
  ('branding', 'website_url', 'https://www.saoluis.ma.gov.br', 'string', 'URL do site da prefeitura'),
  ('branding', 'logo_url', '', 'string', 'Logo da prefeitura (Base64 ou URL)'),
  
  -- PDF
  ('pdf', 'page_size', 'A4', 'string', 'Tamanho da página do PDF'),
  ('pdf', 'include_header', 'true', 'boolean', 'Incluir cabeçalho no PDF'),
  ('pdf', 'include_footer', 'true', 'boolean', 'Incluir rodapé no PDF'),
  ('pdf', 'footer_text', 'Diário Oficial Municipal - {municipality} - {uf}', 'string', 'Texto do rodapé'),
  
  -- Banco de dados
  ('database', 'auto_backup', 'true', 'boolean', 'Backup automático do banco'),
  ('database', 'backup_frequency_days', '7', 'number', 'Frequência de backup (dias)');
