# Create KMS key
resource "aws_kms_key" "week7-kmsKey" {
  description              = "Week 7 KMS key"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
}

# Alias the KMS key
resource "aws_kms_alias" "week7-kmsKeyAlias" {
  name          = "alias/week7-kmsKey"
  target_key_id = aws_kms_key.week7-kmsKey.key_id
}

