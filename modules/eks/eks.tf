resource "aws_eks_cluster" "eks" {
    name = "${var.environment}-${var.project_name}"
    role_arn = aws_iam_role.eks.arn
    version = var.eks_version

    vpc_config {
        endpoint_private_access = false
        endpoint_public_access = true

      subnet_ids = var.private_subnet_ids
    }

    access_config {
      authentication_mode = "API"
      bootstrap_cluster_creator_admin_permissions = true
    }

    depends_on = [ aws_iam_role_policy_attachment.eks ]
}