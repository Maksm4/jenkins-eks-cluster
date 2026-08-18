module "addons" {
  source                     = "../../../modules/k8s-addons"
  helm_metrics_server_values = "${path.module}/values/metrics-server.yaml"
  cluster_name               = data.terraform_remote_state.eks.outputs.cluster_name
}