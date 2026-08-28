variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability zones to deploy into"
  type        = list(string)
}

variable "app_port" {
  description = "Port the lims service listens on (used for security group rules)"
  type        = number
}
