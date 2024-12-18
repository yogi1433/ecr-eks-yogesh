terraform {
  backend "s3" {
    bucket         = "terraform-stat-file-lock-eks"    # Replace with your S3 bucket name
    key            = "terraform/state.tfstate"          # Path inside the bucket to store the state file
    region         = "ap-south-1"                       # Mumbai region
    dynamodb_table = "terraform-lock-table"             # DynamoDB table for state locking
    encrypt        = true                               # Encrypt the state file in S3
  }
}

