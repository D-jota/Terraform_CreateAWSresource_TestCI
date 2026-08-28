output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "data_subnet_ids" {
  value = aws_subnet.data[*].id
}

output "ecs_sg_id" {
  value = aws_security_group.ecs.id
}

output "nlb_sg_id" {
  value = aws_security_group.nlb.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}
