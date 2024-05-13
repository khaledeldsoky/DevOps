output "nat_id" {
  value = aws_nat_gateway.nat.id
}

output "gateway_id" {
  value = aws_internet_gateway.gw.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnets" {
  value =  {for s in aws_subnet.subents : s.tags["Name"] => s.id}
}