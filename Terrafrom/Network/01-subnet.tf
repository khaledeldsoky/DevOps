resource "aws_subnet" "subents" {
  for_each = var.subents

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.AZ
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  
  tags = {
    Name                                   = each.key
    "kubernetes.io/role/${each.value.elb}" = "1"
    "kubernetes.io/cluster/cluster"        = "shared"
  }

}
