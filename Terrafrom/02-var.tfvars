# ----------------------- Network ----------------------- #

vpc_cidr_block = "10.0.0.0/16"

pr_subnet_1 = {
  cidr_block    = "10.0.1.0/24"
  route_table   = "pr_route_table"
}

pr_subnet_2 = {
  cidr_block    = "10.0.2.0/24"
  route_table   = "pr_route_table"
}

pb_subnet_1 = {
  cidr_block    = "10.0.3.0/24"
  route_table   = "pb_route_table"
}



nat_subnet       = "pb_subnet_1"
route_cidr_block = "0.0.0.0/0"

# ----------------------- EC2 ----------------------- #

pb_ec2 = {
  instance_type               = "t3.medium"
  associate_public_ip_address = true
}
