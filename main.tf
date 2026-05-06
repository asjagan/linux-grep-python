# Terraform Configuration Block
# This block configures Terraform settings and required providers
terraform {
  required_providers {
    # AWS provider - Required to manage AWS resources
    # Version ~> 5.0 means any version 5.x.x (ensures compatibility)
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider Configuration
# Specifies which AWS region to deploy resources to
provider "aws" {
  region = var.aws_region
}

# S3 Bucket Resource
# Creates a new S3 bucket with the specified name
# Note: S3 bucket names must be globally unique across all AWS accounts
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  # Tags for organizing and identifying resources
  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

# S3 Bucket Versioning Configuration
# Enables versioning to keep multiple versions of objects in the bucket
# Useful for backup and recovery purposes
resource "aws_s3_bucket_versioning" "example" {
  # Reference the bucket created above
  bucket = aws_s3_bucket.example.id

  versioning_configuration {
    # Enabled = keeps all versions of objects
    status = "Enabled"
  }
}

# S3 Bucket Server-Side Encryption Configuration
# Encrypts all objects in the bucket at rest using AES256 algorithm
# This is a best practice for data security and compliance
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    apply_server_side_encryption_by_default {
      # AES256: AWS-managed encryption keys (free, simple, no key management)
      # Alternative: "aws:kms" for customer-managed keys (more control, paid)
      sse_algorithm = "AES256"
    }
  }
}

# Output: Bucket Name
# Returns the name of the created S3 bucket for reference
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.example.id
}

# Output: Bucket ARN
# Returns the Amazon Resource Name (ARN) of the bucket
# Useful for referencing the bucket in IAM policies and other configurations
output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.example.arn
}
