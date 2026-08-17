data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "jenkins-eks-cluster-tfstate"
    key    = "dev/eks/terraform.tfstate"
    region = "eu-north-1"
  }
}

data "aws_eks_cluster" "eks" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}