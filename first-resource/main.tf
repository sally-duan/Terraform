
provider "aws" {
  access_key = "sally_access_key"
  secret_key = "sally_secrete_accesskey"
  region     = "us-west-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "mysubnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-1a"
}

resource "aws_security_group" "my_sg" {
  name        = "my_sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.myvpc.id

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

resource "aws_instance" "ec2" {
  ami                    = "ami-0d1891272a8f97fb4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.mysubnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
}
