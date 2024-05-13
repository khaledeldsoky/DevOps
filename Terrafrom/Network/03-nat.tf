resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.subents[var.nat_subnet].id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.gw]

}


resource "aws_eip" "lb" {
  domain   = "vpc"
}