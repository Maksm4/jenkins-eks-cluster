output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}