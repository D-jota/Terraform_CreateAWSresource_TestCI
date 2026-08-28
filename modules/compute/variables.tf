variable "project" {
  description = "Project name used to prefix resource names"
  type        = string
  default     = "lims"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID hosting the ECS and NLB"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for Fargate tasks and the internal NLB"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "nlb_sg_id" {
  description = "Security group ID for the NLB"
  type        = string
}

variable "app_image" {
  description = "Container image for the lims service"
  type        = string
}

variable "app_port" {
  description = "Container port for the lims service"
  type        = number
}

variable "app_cpu" {
  description = "CPU units for each Fargate task"
  type        = number
}

variable "app_memory" {
  description = "Memory MiB for each Fargate task"
  type        = number
}

variable "desired_count" {
  description = "Desired number of Fargate tasks"
  type        = number
}

variable "db_secret_arn" {
  description = "ARN of the Secrets Manager secret holding RDS credentials"
  type        = string
}

variable "db_host" {
  description = "RDS endpoint injected into the container environment"
  type        = string
}

variable "db_port" {
  description = "RDS port injected into the container environment"
  type        = number
}

variable "db_name" {
  description = "Database name injected into the container environment"
  type        = string
}

variable "db_username" {
  description = "Database username injected into the container environment"
  type        = string
}
