resource "tls_private_key" "rsa-4096" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "key" {

  key_name   = "khaled"
  public_key = tls_private_key.rsa-4096.public_key_openssh

  provisioner "local-exec" {
    command = <<EOF
    echo "${tls_private_key.rsa-4096.private_key_openssh}" > khaled.pem
    chmod 600 khaled.pem    
    EOF
  }

  tags = {
    Name = "pb_key"
  }
}


