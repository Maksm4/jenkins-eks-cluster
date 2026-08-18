module "network" {
  source = "../../../modules/network"

  cidr_block_vpc = "10.5.0.0/16"
  environment    = "dev"
  region         = "eu-north-1"
  az             = ["eu-north-1a", "eu-north-1b"]
  project_name   = "jenkins-eks"
}