resource "aws_route_table" "route_table" {
  for_each = var.route_table
  vpc_id   = aws_vpc.vpc.id

  route {
    cidr_block = each.value.cidr_block
    gateway_id = each.value.gateway_id
  }

  tags = {
    Name = each.key
  }

}
