resource "aws_s3_bucket" "example" {
  bucket = "my-tf-ec2-bucket"

  tags = {
    Name        = "EC2 bucket"
  }
}