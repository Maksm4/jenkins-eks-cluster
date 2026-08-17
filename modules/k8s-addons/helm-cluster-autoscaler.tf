resource "helm_release" "cluster_autoscaler" {
    name = "autoscaler"

    repository = "https://kubernetes.github.io/autoscaler"
    chart = "cluster-autoscaler"
    namespace = "kube-system"
    version = "9.59.0"

    set = [ 
    {
        name = "rbac.serviceAccount.name"
        value = "cluster-autoscaler"
    },
    {
        name = "autoDiscovery.clusterName"
        value = var.cluster_name
    },
    {
        name = "awsRegion",
        value = "eu-north-1"
    }
     ]
}