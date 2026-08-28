output "db_secret_arn" {
  value = aws_secretsmanager_secret.db.arn
}

output "db_address" {
  value = aws_db_instance.sqlserver.address
}

output "db_port" {
  value = aws_db_instance.sqlserver.port
}

output "db_name" {
  value = aws_db_instance.sqlserver.db_name
}

output "db_username" {
  value = aws_db_instance.sqlserver.username
}
