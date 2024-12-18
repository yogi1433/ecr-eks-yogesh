resource "aws_s3_bucket" "s3_bucket" {
  bucket = "terraform-stat-file-lock-eks"  # Replace with your S3 bucket name
  acl    = "private"

  versioning {
    enabled = true  # Enable versioning for state file tracking
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock_table" {
  name           = "terraform-lock-table"  # DynamoDB table name for state locking
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  stream_enabled = false
}

