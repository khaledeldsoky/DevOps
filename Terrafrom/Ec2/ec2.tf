resource "aws_instance" "ec2" {
  for_each = var.ec2
  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  subnet_id                   = each.value.subnet_id
  associate_public_ip_address = each.value.associate_public_ip_address
  security_groups             = [each.value.security_groups]
  key_name                    = each.value.key_name
  
  root_block_device {
    volume_size = 30 
    volume_type = "gp2"
  }
  
  tags = {
    Name = each.key
  }
}
