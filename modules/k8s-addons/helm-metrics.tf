resource "helm_release" "metrics-server" {
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart = "metrics-server"

  name = var.metrics_server_name
  namespace = "kube-system"
  version = "3.13.1"

    atomic          = true
    cleanup_on_fail = true

  values = [ 
    var.helm_metrics_server_values != "" ? file(var.helm_metrics_server_values) : file("${path.module}/values/metrics-server.yaml")
    ]
}