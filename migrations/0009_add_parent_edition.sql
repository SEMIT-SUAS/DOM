-- Migration: Add parent edition reference for supplemental editions
-- Description: Supplemental editions should reference the normal edition of the same date

-- Add parent_edition_id column
ALTER TABLE editions ADD COLUMN parent_edition_id INTEGER;

-- Add foreign key constraint (SQLite doesn't enforce FK in ALTER, but good to document)
-- FOREIGN KEY (parent_edition_id) REFERENCES editions(id)

-- Create index for performance
CREATE INDEX IF NOT EXISTS idx_editions_parent ON editions(parent_edition_id);
