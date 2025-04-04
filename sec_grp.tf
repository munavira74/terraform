provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}

resource "aws_security_group" "example_sg" {
  name        = "munavira_security_group"
  description = "Example security group"
  vpc_id      = "vpc-0257563c6624c7848"  # Replace with your VPC ID

  tags = {
    Name        = "example_security_group"
    Environment = "production"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows SSH access from any IP
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows HTTP access from any IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

