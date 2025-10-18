-- Add missing columns to attachments table
ALTER TABLE attachments ADD COLUMN original_name TEXT;
ALTER TABLE attachments ADD COLUMN uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Update existing records to have uploaded_at = created_at
UPDATE attachments SET uploaded_at = created_at WHERE uploaded_at IS NULL;
