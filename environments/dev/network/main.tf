module "network" {
    source = "../../../modules/network"

    cidr_block_vpc = "10.5.0.0/16"
    environment = "dev"
    region = "eu-north-1"
}