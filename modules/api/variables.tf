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
  description = "AWS region (needed to build the invoke URL)"
  type        = string
}

variable "nlb_arn" {
  description = "ARN of the internal NLB the VPC Link targets"
  type        = string
}

variable "nlb_dns_name" {
  description = "DNS name of the internal NLB"
  type        = string
}

variable "app_port" {
  description = "Port the NLB listens on"
  type        = number
}

variable "stage_name" {
  description = "API Gateway deployment stage name"
  type        = string
}

variable "enable_authorizer" {
  description = "Require a Cognito JWT on API methods"
  type        = bool
}

variable "user_pool_arn" {
  description = "Cognito User Pool ARN used by the authorizer"
  type        = string
}
