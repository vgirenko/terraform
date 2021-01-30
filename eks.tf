resource aws_eks_cluster vg_eks_cluster {
  name     = "vg_cluster"
  role_arn = aws_iam_role.vg_eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.private-subnets[0].id, aws_subnet.private-subnets[1].id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_cluster_eks_vpc_resource_controller,
  ]
}
resource aws_eks_node_group vg-node-group {
  cluster_name = aws_eks_cluster.vg_eks_cluster.name
  node_group_name = "vg-eks-node-group"
  node_role_arn = aws_iam_role.vg_eks_node_group.name
  subnet_ids = [aws_subnet.private-subnets[0].id, aws_subnet.private-subnets[1].id]
  capacity_type = SPOT

  scaling_config {
    desired_size = 1
    max_size = 1
    min_size = 1
  }
}