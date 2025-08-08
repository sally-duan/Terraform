provider "aws" {
  access_key = "AKIAUPH7XADD7KDMYNFK"
  secret_key = "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"
  region     = "us-west-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "DB security group"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # adjust as needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-1a"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-1a"
}


output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "db_subnet_id" {
  value = aws_subnet.private_subnet.id # or whichever subnet you want to use for DB
}

output "db_security_group_id" {
    
  value = aws_security_group.db_sg.id
}


output "vpc_id" {
  value = aws_vpc.myvpc.id
}