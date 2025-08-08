
resource "aws_instance" "web" {
  ami           = "ami-0d1891272a8f97fb4"
  instance_type = "t2.micro"
  #   vpc_security_group_ids = ["sg-043024e6182543843"]
  vpc_security_group_ids = [var.db_security_group_id]
  subnet_id              = var.subnet_id

  user_data = file("./web/server-script.sh")
  tags = {
    Name = "Web Server"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Main IGW"
  }
}
output "pub_ip" {
  value = module.eip.PublicIP
}

module "eip" {
  source      = "../eip"
  instance_id = aws_instance.web.id
}



