resource "aws_eks_cluster" "cluster" {
  name     = "cluster"
  role_arn = data.aws_iam_role.role.arn

  vpc_config {
    subnet_ids = var.cluster_subnet
  }

  tags = {
    Name = "cluster"
  }
}


data "aws_iam_role" "role" {
  name = "LabRole"
}
