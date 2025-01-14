terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

  provider "aws" {
  region = "us-east-1"
}

# resource "aws_s3outposts_endpoint" "example" {
#   outpost_id        = data.aws_outposts_outpost.bucketname.id
#   security_group_id = aws_security_group.bucketname.id
#   subnet_id         = aws_subnet.example.id
# }

