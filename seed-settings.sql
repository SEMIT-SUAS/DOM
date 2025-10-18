-- ====================================
-- DOM - System Settings Seed Data
-- Configurações Iniciais do Sistema
-- ====================================

-- Limpar configurações existentes (opcional)
-- DELETE FROM system_settings;

-- CONFIGURAÇÕES DE IDENTIDADE VISUAL
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('prefeitura_nome', '"Prefeitura Municipal de São Luís"', 'Nome completo da prefeitura', datetime('now')),
('prefeitura_cidade', '"São Luís"', 'Nome da cidade', datetime('now')),
('prefeitura_estado', '"MA"', 'Sigla do estado (UF)', datetime('now')),
('prefeitura_cnpj', '"06.307.102/0001-01"', 'CNPJ da prefeitura', datetime('now')),
('prefeitura_endereco', '"Avenida Dom Pedro II, s/n - Centro"', 'Endereço completo', datetime('now')),
('prefeitura_cep', '"65020-480"', 'CEP', datetime('now')),
('prefeitura_telefone', '"(98) 3212-6000"', 'Telefone principal', datetime('now')),
('prefeitura_email', '"gabinete@saoluis.ma.gov.br"', 'Email oficial', datetime('now')),
('prefeitura_site', '"https://www.saoluis.ma.gov.br"', 'Site oficial', datetime('now'));

-- CONFIGURAÇÕES DO DIÁRIO OFICIAL
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('dom_nome_completo', '"Diário Oficial do Município de São Luís"', 'Nome completo do DOM', datetime('now')),
('dom_sigla', '"DOSLS"', 'Sigla do DOM', datetime('now')),
('dom_ano_criacao', '"2025"', 'Ano de criação do DOM digital', datetime('now')),
('dom_periodicidade', '"diária"', 'Periodicidade de publicação', datetime('now')),
('dom_dias_publicacao', '"segunda,terça,quarta,quinta,sexta"', 'Dias da semana de publicação', datetime('now')),
('dom_hora_limite_submissao', '"17:00"', 'Horário limite para submissão', datetime('now')),
('dom_hora_publicacao', '"08:00"', 'Horário padrão de publicação', datetime('now'));

-- CONFIGURAÇÕES DE NUMERAÇÃO
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('edicao_formato_numero', '"NNNNN/AAAA"', 'Formato da numeração (N=número, A=ano)', datetime('now')),
('edicao_reiniciar_anualmente', 'true', 'Reiniciar numeração a cada ano', datetime('now')),
('edicao_incluir_suplementos', 'true', 'Permitir edições suplementares', datetime('now')),
('edicao_formato_suplemento', '"NNNNN/AAAA-S"', 'Formato para suplementos (S=suplemento)', datetime('now'));

-- CONFIGURAÇÕES DE PDF
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('pdf_incluir_cabecalho', 'true', 'Incluir cabeçalho com logo', datetime('now')),
('pdf_incluir_rodape', 'true', 'Incluir rodapé com informações', datetime('now')),
('pdf_incluir_indice', 'true', 'Incluir índice por secretaria', datetime('now')),
('pdf_incluir_qrcode', 'true', 'Incluir QR Code para verificação', datetime('now')),
('pdf_marca_dagua', 'false', 'Incluir marca d água', datetime('now')),
('pdf_marca_dagua_texto', '""', 'Texto da marca d água', datetime('now')),
('pdf_tamanho_fonte_base', '12', 'Tamanho base da fonte (pt)', datetime('now')),
('pdf_orientacao', '"retrato"', 'Orientação da página (retrato/paisagem)', datetime('now')),
('pdf_tamanho_papel', '"A4"', 'Tamanho do papel (A4, Ofício, etc)', datetime('now'));

-- CONFIGURAÇÕES DE ASSINATURA DIGITAL
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('assinatura_digital_ativa', 'true', 'Usar assinatura digital nos PDFs', datetime('now')),
('assinatura_certificado_tipo', '"ICP-Brasil"', 'Tipo de certificado', datetime('now')),
('assinatura_incluir_timestamp', 'true', 'Incluir carimbo de tempo', datetime('now')),
('assinatura_servidor_timestamp', '""', 'URL do servidor de timestamp', datetime('now'));

-- CONFIGURAÇÕES DE NOTIFICAÇÕES
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('notif_email_publicacao', 'true', 'Enviar email ao publicar', datetime('now')),
('notif_email_aprovacao', 'true', 'Enviar email ao aprovar matéria', datetime('now')),
('notif_email_rejeicao', 'true', 'Enviar email ao rejeitar matéria', datetime('now')),
('notif_email_remetente', '"naoresponder@saoluis.ma.gov.br"', 'Email remetente das notificações', datetime('now')),
('notif_email_admin', '"dom@saoluis.ma.gov.br"', 'Email do administrador do sistema', datetime('now'));

-- CONFIGURAÇÕES DE PRAZOS
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('prazo_analise_dias', '3', 'Prazo para análise de matérias (dias úteis)', datetime('now')),
('prazo_correcao_dias', '2', 'Prazo para correção de matérias rejeitadas (dias úteis)', datetime('now')),
('prazo_publicacao_minimo', '1', 'Dias mínimos de antecedência para publicação', datetime('now')),
('prazos_dias_uteis', '[0,1,2,3,4,5,6]', 'Dias da semana úteis para envio (0=Dom, 1=Seg...6=Sáb)', datetime('now'));

-- CONFIGURAÇÕES DE ACESSO PÚBLICO
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('acesso_publico_ativo', 'true', 'Permitir acesso público ao DOM', datetime('now')),
('acesso_busca_ativa', 'true', 'Permitir busca pública de matérias', datetime('now')),
('acesso_download_ativo', 'true', 'Permitir download público dos PDFs', datetime('now')),
('acesso_verificacao_ativa', 'true', 'Permitir verificação de autenticidade', datetime('now'));

-- CONFIGURAÇÕES DE AUDITORIA
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('auditoria_ativa', 'true', 'Registrar logs de auditoria', datetime('now')),
('auditoria_detalhe_nivel', '"completo"', 'Nível de detalhe (básico/completo)', datetime('now')),
('auditoria_retencao_dias', '365', 'Dias de retenção dos logs', datetime('now'));

-- CONFIGURAÇÕES DE BACKUP
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('backup_automatico_ativo', 'true', 'Ativar backup automático', datetime('now')),
('backup_frequencia', '"diária"', 'Frequência de backup (diária/semanal/mensal)', datetime('now')),
('backup_horario', '"02:00"', 'Horário do backup automático', datetime('now')),
('backup_retencao_dias', '30', 'Dias de retenção dos backups', datetime('now'));

-- CONFIGURAÇÕES DE INTERFACE
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
('interface_tema', '"claro"', 'Tema da interface (claro/escuro)', datetime('now')),
('interface_idioma', '"pt-BR"', 'Idioma padrão', datetime('now')),
('interface_formato_data', '"DD/MM/YYYY"', 'Formato de exibição de data', datetime('now')),
('interface_formato_hora', '"HH:mm"', 'Formato de exibição de hora', datetime('now'));
