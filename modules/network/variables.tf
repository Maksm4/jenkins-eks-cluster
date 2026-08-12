variable "cidr_block_vpc" {
    description = "main vpc cidr_block"
    default = "10.0.0.0/16"
}

variable "environment" {
    description = "networks live environment"
    default = "dev"
}

variable "region" {
    description = "region of the network"
    default = "eu-north-1"
}