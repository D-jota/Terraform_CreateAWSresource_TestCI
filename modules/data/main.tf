resource "aws_secretsmanager_secret" "db" {
  name = var.secret_name
}

data "aws_secretsmanager_random_password" "db_master" {
  password_length     = 24
  exclude_characters  = "\\\"'@/"
  exclude_punctuation = false
}

resource "aws_db_subnet_group" "main" {
  name       = "lims-db-subnet-group"
  subnet_ids = var.data_subnet_ids

  tags = {
    Name = "lims-db-subnet-group"
  }
}

resource "aws_db_instance" "sqlserver" {
  identifier                = "lims-sqlserver"
  engine                    = "sqlserver-ex"
  engine_version            = "15.00.4073.23.v1"
  instance_class            = var.db_instance_class
  allocated_storage         = var.db_allocated_storage
  storage_encrypted         = true
  multi_az                  = var.db_multi_az
  db_name                   = var.db_name
  username                  = var.db_username
  password                  = data.aws_secretsmanager_random_password.db_master.random_password
  port                      = 1433
  license_model             = "license-included"
  db_subnet_group_name      = aws_db_subnet_group.main.name
  vpc_security_group_ids    = [var.rds_sg_id]
  backup_retention_period   = 7
  skip_final_snapshot       = false
  final_snapshot_identifier = "lims-sqlserver-final"

  tags = {
    Name = "lims-sqlserver"
  }
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    dbInstanceIdentifier = aws_db_instance.sqlserver.identifier
    engine               = aws_db_instance.sqlserver.engine
    host                 = aws_db_instance.sqlserver.address
    port                 = aws_db_instance.sqlserver.port
    username             = aws_db_instance.sqlserver.username
    dbname               = aws_db_instance.sqlserver.db_name
    password             = aws_db_instance.sqlserver.password
  })
}
