provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}
# Data Source to get the latest Amazon Linux 2 AMI
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Amazon Linux 2 AMI name pattern
  }
}

# EC2 Instance
resource "aws_instance" "example_instance" {
  ami           = data.aws_ami.latest_amazon_linux.id # Dynamically fetch the latest Amazon Linux 2 AMI
  instance_type = "t2.micro"  # Instance type (adjust as needed)
  key_name      = "muna_key"  # Replace with your SSH key name

# Use the existing security group by its name or ID
  security_groups = ["munavira_security"]  # Replace with your existing security group name

  tags = {
    Name = "ExampleInstance"
  }
}
