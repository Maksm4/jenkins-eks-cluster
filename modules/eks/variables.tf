variable "environment" {
  description = "networks live environment"
  default     = "dev"
}

variable "region" {
  description = "region of the network"
  default     = "eu-north-1"
}

variable "project_name" {
  type        = string
  description = "name of the project"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where the EKS cluster will be deployed"
  type        = list(string)
}

variable "eks_version" {
  description = "eks version for the cluster"
  type = number
}