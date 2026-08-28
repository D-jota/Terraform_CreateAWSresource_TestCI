output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = module.auth.user_pool_id
}

output "cognito_user_pool_client_id" {
  description = "Cognito app client ID used for username/password login"
  value       = module.auth.user_pool_client_id
}

output "cognito_user_pool_domain" {
  description = "Cognito hosted UI domain"
  value       = module.auth.user_pool_domain
}

output "nlb_dns_name" {
  description = "Internal Network Load Balancer DNS name"
  value       = module.compute.nlb_dns_name
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.compute.cluster_name
}

output "db_endpoint" {
  description = "RDS SQL Server endpoint (host)"
  value       = module.data.db_address
}

output "db_secret_arn" {
  description = "ARN of the Secrets Manager secret with RDS credentials"
  value       = module.data.db_secret_arn
}

output "api_gateway_invoke_url" {
  description = "Regional API Gateway invoke URL"
  value       = module.api.api_gw_invoke_url
}

output "vpc_link_id" {
  description = "API Gateway VPC Link ID"
  value       = module.api.vpc_link_id
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = module.frontend.cloudfront_domain_name
}

output "s3_bucket_name" {
  description = "S3 static assets bucket name"
  value       = module.frontend.s3_bucket_name
}

output "waf_acl_arn" {
  description = "WAF web ACL ARN attached to CloudFront"
  value       = module.frontend.waf_acl_arn
}

output "route53_hosted_zone_id" {
  description = "Route 53 hosted zone ID (placeholder domain)"
  value       = module.frontend.route53_hosted_zone_id
}

output "route53_name_servers" {
  description = "Name servers of the hosted zone, point the real domain here"
  value       = module.frontend.route53_name_servers
}
