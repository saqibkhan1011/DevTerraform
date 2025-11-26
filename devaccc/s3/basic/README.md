# S3 Bucket - Basic Example

This example creates an S3 bucket with versioning and encryption.

## What You'll Create

- S3 bucket with unique name
- Versioning enabled
- Server-side encryption (AES256)
- Public access blocked
- Lifecycle rules for cost optimization

## Usage

```bash
# Initialize
terraform init

# Plan
terraform plan

# Apply
terraform apply

# Test upload
aws s3 cp test.txt s3://$(terraform output -raw bucket_name)/

# Destroy
terraform destroy
```

## Cost

- **S3 Storage**: $0.023/GB/month (first 50TB)
- **Requests**: Minimal for testing

**Estimated cost**: < $1/month for testing

## What You'll Learn

- Creating S3 buckets
- Bucket versioning
- Server-side encryption
- Public access blocking
- Lifecycle policies
- Bucket policies
