resource "aws_eks_addon" "pod_identity" {
  cluster_name = var.cluster_name
  addon_name = "eks-pod-identity-agent"
  addon_version = var.pod_identity_version
}

resource "aws_iam_role" "cluster_autoscaler" {
  name = "${var.cluster_name}-cluster-autoscaler"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "pods.eks.amazonaws.com"
            },
            "Action": [
                "sts:AssumeRole",
                "sts:TagSession"
            ]
        }
    ]
  })
}

resource "aws_iam_policy" "cluster_autoscaler" {
  name = "${var.cluster_name}-cluster-autoscaler"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    {
    Action = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:DescribeScalingActivities",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeInstanceTypes",
      "ec2:GetInstanceTypesFromInstanceRequirements",
      "eks:DescribeNodegroup"
    ]
    Resource = "*"
    Effect    = "Allow"
  }]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  policy_arn = aws_iam_policy.cluster_autoscaler.arn
  role = aws_iam_role.cluster_autoscaler.name
}

resource "aws_eks_pod_identity_association" "cluster_autoscaler" {
  cluster_name = var.cluster_name
  namespace = "kube-system"
  service_account = "cluster-autoscaler"
  role_arn = aws_iam_role.cluster_autoscaler.arn
}

data "aws_iam_policy_document" "ebs_csi_driver" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "ebs_csi_driver" {
  name = "${var.cluster_name}-ebs-csi-driver"
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_driver.json
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEBSCSIDriverPolicyV2"
  role = aws_iam_role.ebs_csi_driver.name
}

data "aws_iam_policy_document" "ebs_csi_driver_encryption" {
   statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKeyWithoutPlainText",
      "kms:CreateGrant"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "ebs_csi_driver_encryption" {
  name = "${var.cluster_name}-ebs-csi-driver-encryption"
  policy = data.aws_iam_policy_document.ebs_csi_driver_encryption.json
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_encryption" {
  policy_arn = aws_iam_policy.ebs_csi_driver_encryption.arn
  role = aws_iam_role.ebs_csi_driver.name
}

resource "aws_eks_pod_identity_association" "ebs_csi_driver" {
  cluster_name = var.cluster_name
  namespace = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn = aws_iam_role.ebs_csi_driver.arn
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = var.cluster_name
  addon_name = "aws-ebs-csi-driver"
  addon_version = "v1.63.1-eksbuild.1"
}