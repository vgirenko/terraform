//data "aws_eks_cluster" "cluster" {
//  name = module.vg-cluster.cluster_id
//}
//data "aws_eks_cluster_auth" "cluster" {
//  name = module.vg-cluster.cluster_id
//}
//data "aws_subnet" "private" {
//  for_each = aws_subnet.private-subnets.id
//
//  id = each.value
//}
//module "vg-cluster" {
//  source          = "terraform-aws-modules/eks/aws"
//  #count           = 1
//  cluster_name    = "vg-cluster"
//  cluster_version = "1.17"
//  subnets         = data.aws_subnet.private.id
//  vpc_id          = aws_vpc.vg_vpc.id
//
//  worker_groups = [
//    {
//      instance_type = "a1.large"
//      asg_max_size  = 5
//    }
//  ]
//}