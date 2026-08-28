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
