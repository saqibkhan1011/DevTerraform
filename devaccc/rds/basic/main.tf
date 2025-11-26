terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "terraform-learning"
      Environment = "dev"
      ManagedBy   = "terraform"
    }
  }
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Generate random password
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "terraform-learning-db-subnet"
  subnet_ids = data.aws_subnets.default.ids
  
  tags = {
    Name = "terraform-learning-db-subnet"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds" {
  name        = "terraform-learning-rds-sg"
  description = "Allow PostgreSQL access"
  vpc_id      = data.aws_vpc.default.id
  
  ingress {
    description = "PostgreSQL from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "terraform-learning-rds-sg"
  }
}

# DB Parameter Group
resource "aws_db_parameter_group" "postgres" {
  name   = "terraform-learning-postgres"
  family = "postgres15"
  
  parameter {
    name  = "log_connections"
    value = "1"
  }
  
  parameter {
    name  = "log_disconnections"
    value = "1"
  }
  
  tags = {
    Name = "terraform-learning-postgres"
  }
}

# RDS Instance
resource "aws_db_instance" "main" {
  identifier = var.db_identifier
  
  # Engine
  engine         = "postgres"
  engine_version = "15.4"
  
  # Instance
  instance_class    = var.db_instance_class
  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true
  
  # Database
  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_password.result
  port     = 5432
  
  # Network
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  
  # Backup
  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:05:00"
  
  # Monitoring
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  
  # Parameter group
  parameter_group_name = aws_db_parameter_group.postgres.name
  
  # Deletion protection
  deletion_protection = false # Set to true in production!
  skip_final_snapshot = true  # Set to false in production!
  
  # Performance Insights
  performance_insights_enabled = false # Enable in production
  
  tags = {
    Name = var.db_identifier
  }
}
