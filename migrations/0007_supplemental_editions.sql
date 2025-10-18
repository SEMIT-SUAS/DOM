-- Adicionar coluna para edições suplementares
ALTER TABLE editions ADD COLUMN is_supplemental INTEGER DEFAULT 0;
ALTER TABLE editions ADD COLUMN supplemental_number TEXT;

-- Criar índice para buscar edições suplementares
CREATE INDEX IF NOT EXISTS idx_editions_supplemental ON editions(is_supplemental, year);
