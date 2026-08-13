variable "cidr_block_vpc" {
  description = "main vpc cidr_block"
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "networks live environment"
  default     = "dev"
}

variable "region" {
  description = "region of the network"
  default     = "eu-north-1"
}

variable "az" {
  type        = list(string)
  description = "availability zones to put your public and private subnets in"
  default     = ["eu-north-1a"]
}

variable "project_name" {
  type        = string
  description = "name of the project"
}