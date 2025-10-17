-- Migration: Fix matter_type column issue
-- Remove old matter_type TEXT column and keep only matter_type_id

-- Desabilitar foreign keys temporariamente
PRAGMA foreign_keys=OFF;

-- Criar tabela temporária com estrutura correta
CREATE TABLE matters_new (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  summary TEXT,
  matter_type_id INTEGER NOT NULL,
  category_id INTEGER,
  secretaria_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,
  
  status TEXT NOT NULL DEFAULT 'draft' CHECK(status IN ('draft', 'submitted', 'under_review', 'approved', 'rejected', 'published', 'scheduled', 'archived')),
  
  version INTEGER DEFAULT 1,
  parent_matter_id INTEGER,
  
  submitted_at DATETIME,
  reviewed_at DATETIME,
  approved_at DATETIME,
  published_at DATETIME,
  scheduled_date DATETIME,
  
  reviewer_id INTEGER,
  review_notes TEXT,
  rejection_reason TEXT,
  
  signature_hash TEXT,
  signature_type TEXT CHECK(signature_type IN ('eletronica', 'digital', 'none')),
  signed_by INTEGER,
  signed_at DATETIME,
  
  edition_number TEXT,
  page_number INTEGER,
  pdf_url TEXT,
  pdf_hash TEXT,
  
  layout_columns INTEGER DEFAULT 1 CHECK(layout_columns IN (1, 2)),
  priority TEXT DEFAULT 'normal' CHECK(priority IN ('urgent', 'high', 'normal', 'low')),
  publication_date DATE,
  observations TEXT,
  submitted_by INTEGER REFERENCES users(id),
  canceled_at DATETIME,
  canceled_by INTEGER REFERENCES users(id),
  cancelation_reason TEXT,
  server_timestamp DATETIME,
  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (matter_type_id) REFERENCES matter_types(id),
  FOREIGN KEY (category_id) REFERENCES categories(id),
  FOREIGN KEY (secretaria_id) REFERENCES secretarias(id),
  FOREIGN KEY (author_id) REFERENCES users(id),
  FOREIGN KEY (reviewer_id) REFERENCES users(id),
  FOREIGN KEY (signed_by) REFERENCES users(id),
  FOREIGN KEY (parent_matter_id) REFERENCES matters(id)
);

-- Copiar dados da tabela antiga para nova (se houver dados)
-- Se houver matter_type texto, tentar mapear para matter_type_id
INSERT INTO matters_new (
  id, title, content, summary, matter_type_id, category_id, secretaria_id, author_id,
  status, version, parent_matter_id, submitted_at, reviewed_at, approved_at, 
  published_at, scheduled_date, reviewer_id, review_notes, rejection_reason,
  signature_hash, signature_type, signed_by, signed_at, edition_number, page_number,
  pdf_url, pdf_hash, layout_columns, priority, publication_date, observations,
  submitted_by, canceled_at, canceled_by, cancelation_reason, server_timestamp,
  created_at, updated_at
)
SELECT 
  id, title, content, summary, 
  COALESCE(matter_type_id, 1) as matter_type_id, -- Default to 1 if NULL
  category_id, secretaria_id, author_id,
  status, version, parent_matter_id, submitted_at, reviewed_at, approved_at,
  published_at, scheduled_date, reviewer_id, review_notes, rejection_reason,
  signature_hash, signature_type, signed_by, signed_at, edition_number, page_number,
  pdf_url, pdf_hash, layout_columns, priority, publication_date, observations,
  submitted_by, canceled_at, canceled_by, cancelation_reason, server_timestamp,
  created_at, updated_at
FROM matters;

-- Remover tabela antiga
DROP TABLE matters;

-- Renomear nova tabela
ALTER TABLE matters_new RENAME TO matters;

-- Recriar índices
CREATE INDEX IF NOT EXISTS idx_matters_secretaria ON matters(secretaria_id);
CREATE INDEX IF NOT EXISTS idx_matters_author ON matters(author_id);
CREATE INDEX IF NOT EXISTS idx_matters_status ON matters(status);
CREATE INDEX IF NOT EXISTS idx_matters_created_at ON matters(created_at);
CREATE INDEX IF NOT EXISTS idx_matters_matter_type_id ON matters(matter_type_id);

-- Reabilitar foreign keys
PRAGMA foreign_keys=ON;
