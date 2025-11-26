# RDS Database - Basic Example

This example creates a PostgreSQL RDS instance with proper security configuration.

## What You'll Create

- RDS PostgreSQL database (db.t3.micro)
- DB subnet group
- Security group for database access
- Parameter group for custom settings
- Automated backups enabled

## ⚠️ Important Notes

- **Cost**: RDS instances are NOT free tier eligible for PostgreSQL
- **Estimated cost**: ~$15-20/month for db.t3.micro
- **Destroy when done**: Run `terraform destroy` to avoid charges

## Usage

```bash
# Initialize
terraform init

# Plan
terraform plan

# Apply (will take 5-10 minutes)
terraform apply

# Get connection info
terraform output db_endpoint
terraform output db_password

# Connect to database
psql -h $(terraform output -raw db_endpoint) -U admin -d myappdb

# Destroy (IMPORTANT!)
terraform destroy
```

## What You'll Learn

- Creating RDS instances
- DB subnet groups
- Security groups for databases
- Parameter groups
- Managing sensitive outputs (passwords)
- Database backup configuration
