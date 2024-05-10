data "aws_caller_identity" "current" {}
# runs aws sts get-caller-identity --profile {NAME}

resource "aws_kms_key" "objects" {
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7
}

resource "aws_s3_bucket" "terraform_state_redhat_dev" {
  bucket = "terraform-state-ha"

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
    }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state_redhat_dev.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state_redhat_dev.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.objects.arn
      sse_algorithm = "aws:kms"
    }
  }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state_redhat_dev.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]
}