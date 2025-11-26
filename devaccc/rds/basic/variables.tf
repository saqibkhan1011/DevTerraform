variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
  default     = "terraform-learning-db"
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "myappdb"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "admin"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}
