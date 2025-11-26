variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string
}

variable "enable_bucket_policy" {
  description = "Enable bucket policy to enforce TLS"
  type        = bool
  default     = true
}
