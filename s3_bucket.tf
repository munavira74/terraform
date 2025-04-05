provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "munas-bucket-unique-12345"  # Change to a unique bucket name
  acl    = "private"  # Set bucket ACL as private
}
