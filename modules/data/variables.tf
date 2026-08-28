variable "data_subnet_ids" {
  description = "IDs of the data subnets used for the DB subnet group"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "Security group ID attached to the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Name of the initial database"
  type        = string
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage in GiB"
  type        = number
}

variable "db_multi_az" {
  description = "Enable Multi-AZ (not supported by SQL Server Express)"
  type        = bool
}

variable "secret_name" {
  description = "Name of the Secrets Manager secret holding DB credentials"
  type        = string
}
