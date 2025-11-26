# EC2 Instance - Basic Example

This example creates a simple EC2 instance in the default VPC.

## What You'll Create

- 1 EC2 t2.micro instance
- Security group allowing SSH access
- Key pair for SSH authentication

## Prerequisites

- AWS CLI configured
- Terraform installed
- SSH key pair (or we'll create one)

## Files

- `main.tf` - Main configuration
- `variables.tf` - Input variables
- `outputs.tf` - Output values
- `terraform.tfvars.example` - Example variable values

## Usage

### 1. Create SSH Key Pair (if you don't have one)

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/terraform-aws -N ""
```

### 2. Copy example variables

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your values.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the plan

```bash
terraform plan
```

### 5. Apply configuration

```bash
terraform apply
```

### 6. Connect to instance

```bash
# Get the public IP from outputs
terraform output instance_public_ip

# SSH to instance
ssh -i ~/.ssh/terraform-aws ubuntu@<instance_public_ip>
```

### 7. Destroy resources

```bash
terraform destroy
```

## Cost

- **t2.micro**: Free tier eligible (750 hours/month for 12 months)
- **EBS Volume**: ~$0.10/GB/month (8GB = ~$0.80/month)

**Estimated cost**: $0/month (free tier) or ~$8/month (after free tier)

## What You'll Learn

- Creating EC2 instances
- Security groups and ingress rules
- Using data sources to query AMIs
- SSH key pairs
- Resource dependencies
- Outputs for accessing created resources
