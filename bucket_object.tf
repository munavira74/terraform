provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-muna-bucket-12345"  # Ensure the bucket name is globally unique
}
# Block public access settings for the bucket (disable BlockPublicAcls)
resource "aws_s3_bucket_public_access_block" "my_bucket_block" {
  bucket = aws_s3_bucket.my_bucket.bucket

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
# Upload a file to the S3 bucket (set the file to public-read)
resource "aws_s3_bucket_object" "my_file" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "hi"  # The name of the file in S3
  source = "/home/munavira/terraform/hi"  # Path to the local file
}
# Apply a bucket policy to allow public read access to all objects in the bucket
resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.bucket

  # Public read access to all objects in the bucket
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.my_bucket.bucket}/*"
      }
    ]
  })
}

