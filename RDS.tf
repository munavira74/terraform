provider "aws" {
  region = "ap-south-1"
  profile = "default"
}

resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "mydb"              # <-- corrected from 'name'
  username             = "admin"
  password             = "MySecurePassword123"
  skip_final_snapshot  = true
  publicly_accessible  = true

  db_subnet_group_name     = "my-subnet-group"   # Replace with your subnet group
  vpc_security_group_ids   = ["sg-097bc8359a66e0914"]     # Replace with your SG

  tags = {
    Name = "SimpleRDS"
  }
}

