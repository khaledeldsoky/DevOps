variable "vpc_cidr_block" {
  type = string
}

variable "subents" {
  type = map(object({
    cidr_block              = string
    AZ                      = string
    route_table             = string
    elb                     = string
    map_public_ip_on_launch = bool
  }))
}

variable "route_table" {
  type = map(object({
    cidr_block = string
    gateway_id = string
  }))
}

variable "nat_subnet" {
  type = string
}


