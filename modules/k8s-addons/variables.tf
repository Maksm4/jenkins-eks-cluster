variable "helm_metrics_server_values" {
  default = ""
  description = "helm chart for metric server values path"
}

variable "metrics_server_name" {
    default = "metrics-server"
    description = "name of the metrics server helm chart"
}

variable "pod_identity_version" {
  default = "v1.4.0-eksbuild.1"
}

variable "cluster_name" {
  description = "cluster name"
}