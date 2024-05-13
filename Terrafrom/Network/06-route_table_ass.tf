resource "aws_route_table_association" "association" {
  for_each = var.subents

  subnet_id      = aws_subnet.subents[each.key].id
  route_table_id = aws_route_table.route_table[each.value.route_table].id
  
}
