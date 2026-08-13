output "private_subnet_ids" {
  description = "Passing the private subnets from the module to the state file"
  value       = module.network.private_subnet_ids 
}

output "public_subnet_ids" {
  value       = module.network.public_subnet_ids
}

output "main_vpc_id" {
  value       = module.network.main_vpc_id
}