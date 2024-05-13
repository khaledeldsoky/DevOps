# ----------------------- Network ----------------------- #
variable "vpc_cidr_block" {
  type = string
}

variable "pr_subnet_1" {
  type = object({
    cidr_block    = string
    route_table   = string
  })
}

variable "pr_subnet_2" {
  type = object({
    cidr_block    = string
    route_table   = string
  })
}

variable "pb_subnet_1" {
  type = object({
    cidr_block    = string
    route_table   = string
  })
}



variable "nat_subnet" {
  type = string
}

variable "route_cidr_block" {
  type = string
}

# ----------------------- EC2 ----------------------- #

variable "pb_ec2" {
  type = object({
    instance_type               = string
    associate_public_ip_address = bool
  })
}
