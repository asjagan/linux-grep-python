# Variable: AWS Region
# Defines which AWS region to deploy resources to
# Default: us-east-1 (Virginia)
# Other options: us-west-2, eu-west-1, ap-southeast-1, etc.
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Variable: S3 Bucket Name
# REQUIRED: Must be provided in terraform.tfvars
# Constraints:
#   - Must be unique globally across all AWS accounts
#   - 3-63 characters long
#   - Lowercase letters, numbers, hyphens only
#   - Cannot start or end with a hyphen
# Example: my-app-bucket-12345
variable "bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string
}

# Variable: Environment Name
# Used for resource tagging and identification
# Common values: dev, staging, prod
# Default: dev
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
