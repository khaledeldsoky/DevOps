output "security_group" {
  value = aws_security_group.pb.id
}

output "key_name" {
  value = aws_key_pair.key.key_name
}