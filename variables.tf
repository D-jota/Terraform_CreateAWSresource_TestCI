variable "region" {
  description = "AWS region to deploy into (architecture requires eu-west-3 Paris)"
  type        = string
  default     = "eu-west-3"
}

variable "project" {
  description = "Project name used to prefix resource names"
  type        = string
  default     = "lims"
}

variable "environment" {
  description = "Deployment environment (dev/staging/prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones to deploy into"
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b"]
}

variable "app_image" {
  description = "Container image for the lims service. Placeholder nginx is used until the real image is available."
  type        = string
  default     = "nginx:latest"
}

variable "app_port" {
  description = "Port the lims service container listens on"
  type        = number
  default     = 80
}

variable "app_cpu" {
  description = "CPU units (vCPU * 1024) allocated to each Fargate task"
  type        = number
  default     = 256
}

variable "app_memory" {
  description = "Memory (MiB) allocated to each Fargate task"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of Fargate tasks running behind the NLB"
  type        = number
  default     = 2
}

variable "db_name" {
  description = "Name of the initial database created on the SQL Server instance"
  type        = string
  default     = "lims"
}

variable "db_username" {
  description = "Master username for the RDS SQL Server instance"
  type        = string
  default     = "limsadmin"
}

variable "db_instance_class" {
  description = "RDS SQL Server instance class (low cost default)"
  type        = string
  default     = "db.t3.small"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GiB (min 20 for SQL Server Express)"
  type        = number
  default     = 20
}

variable "db_multi_az" {
  description = "Whether to enable Multi-AZ. SQL Server Express does NOT support Multi-AZ, so keep false for Express."
  type        = bool
  default     = false
}

variable "db_secret_name" {
  description = "Name of the Secrets Manager secret holding RDS credentials"
  type        = string
  default     = "lims/db/main"
}

variable "s3_bucket_name" {
  description = "Globally unique name of the S3 bucket for static assets"
  type        = string
  default     = "lims-static-assets"
}

variable "hosted_zone_name" {
  description = "Placeholder public domain for Route 53. Replace with a domain you own and add an ACM certificate to go live."
  type        = string
  default     = "lims.example.com"
}

variable "geo_locations" {
  description = "Continent codes used for Route 53 Geolocation Routing records"
  type        = list(string)
  default     = ["EU", "NA", "AS", "OC", "SA", "AF"]
}

variable "cloudfront_waf_rate_limit" {
  description = "WAF rate-based rule limit (requests per 5 minutes per IP)"
  type        = number
  default     = 2000
}

variable "api_stage_name" {
  description = "API Gateway deployment stage name"
  type        = string
  default     = "v1"
}

variable "enable_authorizer" {
  description = "Whether to require a Cognito JWT on API Gateway methods"
  type        = bool
  default     = true
}
