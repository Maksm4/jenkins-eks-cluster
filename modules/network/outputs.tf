output "main_vpc_id" {
  description = "ID of the vpc"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
    description = "private subnets ids as a list"
    value = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "public subnets ids as a list"
  value = aws_subnet.public[*].id
}