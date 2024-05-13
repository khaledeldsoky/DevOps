output "ec2_pb_ip" {
  value = aws_instance.ec2["pb_ec2"].public_ip
}