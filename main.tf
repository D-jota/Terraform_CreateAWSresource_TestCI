provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

module "networking" {
  source   = "./modules/networking"
  vpc_cidr = var.vpc_cidr
  azs      = var.azs
  app_port = var.app_port
}

module "auth" {
  source = "./modules/auth"
}

module "data" {
  source               = "./modules/data"
  data_subnet_ids      = module.networking.data_subnet_ids
  rds_sg_id            = module.networking.rds_sg_id
  db_name              = var.db_name
  db_username          = var.db_username
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_multi_az          = var.db_multi_az
  secret_name          = var.db_secret_name
}

module "compute" {
  source             = "./modules/compute"
  region             = var.region
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  ecs_sg_id          = module.networking.ecs_sg_id
  nlb_sg_id          = module.networking.nlb_sg_id
  app_image          = var.app_image
  app_port           = var.app_port
  app_cpu            = var.app_cpu
  app_memory         = var.app_memory
  desired_count      = var.desired_count
  db_secret_arn      = module.data.db_secret_arn
  db_host            = module.data.db_address
  db_port            = module.data.db_port
  db_name            = module.data.db_name
  db_username        = module.data.db_username
}

module "api" {
  source            = "./modules/api"
  region            = var.region
  nlb_arn           = module.compute.nlb_arn
  nlb_dns_name      = module.compute.nlb_dns_name
  app_port          = var.app_port
  stage_name        = var.api_stage_name
  enable_authorizer = var.enable_authorizer
  user_pool_arn     = module.auth.user_pool_arn
}

module "frontend" {
  source           = "./modules/frontend"
  region           = var.region
  bucket_name      = var.s3_bucket_name
  api_gw_id        = module.api.api_gw_id
  api_stage_name   = module.api.api_stage_name
  hosted_zone_name = var.hosted_zone_name
  geo_locations    = var.geo_locations
  waf_rate_limit   = var.cloudfront_waf_rate_limit
}
