resource "aws_eks_node_group" "agents" {
    cluster_name = aws_eks_cluster.eks.name
    node_group_name = "jenkins-agents"
    node_role_arn = aws_iam_role.node.arn
    version = var.eks_version

    subnet_ids = var.private_subnet_ids

    scaling_config {
      desired_size = 1
      min_size = 1
      max_size = 3
    }

    update_config {
      max_unavailable = 1
    }

    taint { 
        key    = "dedicated"
        value  = "jenkins"
        effect = "NO_SCHEDULE"
     }

    taint {
      key = "jenkinsType"
      value = "agent"
      effect = "NO_SCHEDULE"
    }

    labels = {
      dedicated   = "jenkins"
      jenkinsType = "agent"
    }

    tags = {
      "k8s.io/cluster-autoscaler/enabled"                  = "true"
      "k8s.io/cluster-autoscaler/${aws_eks_cluster.eks.name}" = "owned"
    }

    capacity_type = "SPOT"
    instance_types = ["t3.medium"]

    depends_on = [ 
        aws_iam_role_policy_attachment.ec2_container_registry_read_policy,
        aws_iam_role_policy_attachment.eks_cni_policy,
        aws_iam_role_policy_attachment.eks_worker_node_policy
     ]

     lifecycle {
       ignore_changes = [ scaling_config[0].desired_size ]
     }
}

resource "aws_eks_node_group" "controller" {
    cluster_name = aws_eks_cluster.eks.name
    node_group_name = "jenkins-controller"
    node_role_arn = aws_iam_role.node.arn
    version = var.eks_version

    subnet_ids = var.private_subnet_ids

    scaling_config {
      desired_size = 1
      min_size = 1
      max_size = 1
    }

    taint { 
        key    = "dedicated"
        value  = "jenkins"
        effect = "NO_SCHEDULE"
     }

    taint {
      key = "jenkinsType"
      value = "controller"
      effect = "NO_SCHEDULE"
    }

    labels = {
      dedicated   = "jenkins"
      jenkinsType = "controller"
    }

    tags = {
      "k8s.io/cluster-autoscaler/enabled"                  = "true"
      "k8s.io/cluster-autoscaler/${aws_eks_cluster.eks.name}" = "owned"
    }

    capacity_type = "ON_DEMAND"
    instance_types = ["t3.large"]

    depends_on = [ 
        aws_iam_role_policy_attachment.ec2_container_registry_read_policy,
        aws_iam_role_policy_attachment.eks_cni_policy,
        aws_iam_role_policy_attachment.eks_worker_node_policy
     ]
}

resource "aws_eks_node_group" "system" {
  cluster_name = aws_eks_cluster.eks.name
  subnet_ids = var.private_subnet_ids
  node_role_arn = aws_iam_role.node.arn
  version = var.eks_version
  node_group_name = "system"

  scaling_config {
    desired_size = 1
    min_size = 1
    max_size = 3
  }

  tags = {
      "k8s.io/cluster-autoscaler/enabled"                  = "true"
      "k8s.io/cluster-autoscaler/${aws_eks_cluster.eks.name}" = "owned"
    }

  instance_types = ["t3.medium", "t3.large"]
  capacity_type = "ON_DEMAND"
  
  depends_on = [
    aws_iam_role_policy_attachment.ec2_container_registry_read_policy,
        aws_iam_role_policy_attachment.eks_cni_policy,
        aws_iam_role_policy_attachment.eks_worker_node_policy
    ]

}