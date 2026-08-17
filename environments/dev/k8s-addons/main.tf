module "metrics_server" {
  source                     = "../../../modules/k8s-addons"
  helm_metrics_server_values = "${path.module}/values/metrics-server.yaml"
}