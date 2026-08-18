data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "jenkins-eks-cluster-tfstate"
    key    = "dev/network/terraform.tfstate"
    region = "eu-north-1"
  }
}