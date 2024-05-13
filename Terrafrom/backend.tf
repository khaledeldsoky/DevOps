terraform {
  backend "s3" {
    bucket = "devops-monitor-s3"
    key    = "s3.tfvars"
    region = "us-east-1"
  }
}

