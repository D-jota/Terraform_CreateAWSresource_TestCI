resource "aws_cognito_user_pool" "main" {
  name                     = "${var.project}-${var.environment}-user-pool"
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  mfa_configuration        = "OFF"

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }
}

resource "aws_cognito_user_pool_client" "app" {
  name                         = "${var.project}-${var.environment}-app-client"
  user_pool_id                 = aws_cognito_user_pool.main.id
  generate_secret              = false
  explicit_auth_flows          = ["ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  supported_identity_providers = ["COGNITO"]
  callback_urls                = ["https://lims.example.com/oauth2/idpresponse"]
  logout_urls                  = ["https://lims.example.com"]
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${var.project}-${var.environment}-${random_id.suffix.hex}"
  user_pool_id = aws_cognito_user_pool.main.id
}
