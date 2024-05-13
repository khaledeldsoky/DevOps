resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "node1"
  node_role_arn   = data.aws_iam_role.role.arn
  subnet_ids      = var.node_subnet

  capacity_type  = "ON_DEMAND"
  instance_types = [ "t3.medium" ]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }
  update_config {
    max_unavailable = 1
  }


}