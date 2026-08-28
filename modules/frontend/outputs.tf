output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.cdn.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.static.bucket
}

output "waf_acl_arn" {
  value = aws_wafv2_web_acl.cloudfront.arn
}

output "route53_hosted_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "route53_name_servers" {
  value = aws_route53_zone.main.name_servers
}
