module "eks" {
  source             = "../../../modules/eks"
  eks_version        = 1.36
  project_name       = "jenkins-eks"
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  environment        = "dev"
  region             = "eu-north-1"
}