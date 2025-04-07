provider "aws" {
  region = "ap-south-1"
}

# Create a Security Group
resource "aws_security_group" "my_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch an EC2 instance using existing key pair
resource "aws_instance" "my_instance" {
  ami           = "ami-03f4878755434977f"  # Amazon Linux 2 AMI in ap-south-1 (Mumbai)
  instance_type = "t2.micro"
  key_name      = "muna_key"
  security_groups = [aws_security_group.my_sg.name]

  tags = {
    Name = "MyInstance"
  }
}

# Create an EBS Volume in the same AZ as the instance
resource "aws_ebs_volume" "my_ebs_volume" {
  availability_zone = aws_instance.my_instance.availability_zone
  size              = 10
  type              = "gp2"

  tags = {
    Name = "MyEBSVolume"
  }
}

# Attach EBS Volume to the EC2 instance
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.my_ebs_volume.id
  instance_id = aws_instance.my_instance.id
  force_detach = true
}

