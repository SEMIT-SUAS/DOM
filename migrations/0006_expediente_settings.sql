-- Adicionar configurações de expediente
INSERT OR REPLACE INTO system_settings (key, value, description, updated_at) VALUES
-- Informações do Expediente
('expediente_prefeitura_nome', 'PREFEITURA DE SÃO LUÍS', 'Nome da prefeitura no expediente', datetime('now')),
('expediente_secretaria_responsavel', 'Secretaria Municipal de Administração - SEMAD', 'Secretaria responsável pela publicação', datetime('now')),
('expediente_imprensa_oficial', 'Imprensa Oficial do Município - Lei n.º 2.483/80', 'Texto da lei da imprensa oficial', datetime('now')),
('expediente_website', 'www.saoluis.ma.gov.br', 'Website da prefeitura', datetime('now')),

-- Autoridades
('expediente_prefeito_nome', 'Eduardo Salim Braide', 'Nome do Prefeito', datetime('now')),
('expediente_prefeito_cargo', 'Prefeito de São Luís', 'Cargo do Prefeito', datetime('now')),
('expediente_secretario_governo_nome', 'Emílio Carlos Murad', 'Nome do Secretário de Governo', datetime('now')),
('expediente_secretario_governo_cargo', 'Secretário de Governo', 'Cargo do Secretário de Governo', datetime('now')),
('expediente_secretario_admin_nome', 'Octávio Augusto Gomes de Figueiredo Soares', 'Nome do Secretário de Administração', datetime('now')),
('expediente_secretario_admin_cargo', 'Secretário de Administração', 'Cargo do Secretário de Administração', datetime('now')),
('expediente_coordenador_imprensa_nome', 'Márcio Antonio de Sousa Brandão', 'Nome do Coordenador de Imprensa', datetime('now')),
('expediente_coordenador_imprensa_cargo', 'Coordenador de Imprensa Oficial', 'Cargo do Coordenador de Imprensa', datetime('now')),

-- Endereço
('expediente_endereco_logradouro', 'Rua Professor Luís Pinho Rodrigues, n.º 15, Jardim Renascença, Ed. Agenor Cossetti', 'Logradouro completo', datetime('now')),
('expediente_endereco_cep', 'CEP: 65075-740 - São Luís - MA', 'CEP e cidade', datetime('now')),

-- Informações do Diário
('diario_titulo', 'Diário Oficial', 'Título do diário', datetime('now')),
('diario_subtitulo', 'Município de São Luís', 'Subtítulo do diário', datetime('now')),
('diario_cidade', 'SÃO LUÍS/MA', 'Cidade do diário', datetime('now')),
('diario_ano_romano', 'ANO XLV', 'Ano em algarismo romano', datetime('now')),
('diario_issn', 'ISSN 2764-8958', 'ISSN do diário', datetime('now')),
('diario_cnpj', '06307102000130', 'CNPJ do município', datetime('now')),

-- Assinatura Digital
('diario_certificado_digital', 'Certificado Digital - Certisign PJ AN-1', 'Informação do certificado', datetime('now')),
('diario_texto_rodape', 'Este documento pode ser verificado no endereço eletrônico https://diariooficial.saoluis.ma.gov.br', 'Texto do rodapé', datetime('now')),
('diario_texto_assinatura', 'Documento assinado com certificado digital e carimbo de tempo, conforme Instrução Normativa N.º 70/2021 do TCE/MA.', 'Texto da assinatura digital', datetime('now'));
