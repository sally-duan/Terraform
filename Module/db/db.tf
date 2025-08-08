resource "aws_instance" "db" {
  ami                    = "ami-0d1891272a8f97fb4"
  instance_type          = "m5.large"
  vpc_security_group_ids = [var.db_security_group_id]
  subnet_id              = var.subnet_id

  tags = {
    Name = "Sally DB Server"
  }
}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}
