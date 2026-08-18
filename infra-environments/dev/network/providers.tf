terraform {
  required_version = ">=1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.58"
    }
  }
  backend "s3" {
    bucket       = "jenkins-eks-cluster-tfstate"
    key          = "dev/network/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = {
      Environment = "dev"
      Project     = "eks-jenkins-cluster"
      ManagedBy   = "Terraform"
    }
  }
}