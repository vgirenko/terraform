data aws_iam_policy_document eks_assume_role_policy {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["eks.amazonaws.com"]
      type        = "Service"
    }
  }
}
resource aws_iam_role vg_eks_cluster_role {
  name = "vg-eks-cluster"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}
resource aws_iam_role_policy_attachment eks_cluster_policy {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.vg_eks_cluster_role.name
}
resource aws_iam_role_policy_attachment eks_cluster_eks_vpc_resource_controller {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.vg_eks_cluster_role.name
}
resource aws_iam_role vg_eks_node_group {
  name = "vg-eks-mode-group"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}
resource aws_iam_policy_attachment AmazonEKSWorkerNodePolicy {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.vg_eks_node_group.name
}
resource aws_iam_policy_attachment AmazonEKS_CNI_Policy {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.vg_eks_node_group.name
}
resource aws_iam_role_policy_attachment AmazonEC2ContainerRegistryReadOnly {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.vg_eks_node_group.name
}