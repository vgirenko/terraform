output vpc_id {
  value       = aws_vpc.vg_vpc.id
  sensitive   = false
  description = "VPC ID"
}
output eks_endpoint{
  value = aws_eks_cluster.vg_eks_cluster.endpoint
}
output kubeconfig-certificate-authority-data {
  value = aws_eks_cluster.vg_eks_cluster.certificate_authority[0].data
}