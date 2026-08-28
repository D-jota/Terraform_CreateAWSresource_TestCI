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
  description = "AWS region (used to build the API Gateway origin domain)"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique name of the S3 static assets bucket"
  type        = string
}

variable "api_gw_id" {
  description = "API Gateway REST API ID used as a CloudFront origin"
  type        = string
}

variable "api_stage_name" {
  description = "API Gateway stage name used as the origin path"
  type        = string
}

variable "hosted_zone_name" {
  description = "Placeholder public domain for the Route 53 hosted zone"
  type        = string
}

variable "geo_locations" {
  description = "Continent codes for Route 53 Geolocation Routing records"
  type        = list(string)
}

variable "waf_rate_limit" {
  description = "WAF rate-based rule limit per IP"
  type        = number
}
