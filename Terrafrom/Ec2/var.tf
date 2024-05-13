variable "ec2" {
  type = map(object({
    ami                         = string
    instance_type               = string
    subnet_id                   = string
    associate_public_ip_address = bool
    security_groups             = string
    key_name                    = string
  }))
}
