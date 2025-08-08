
provider "aws" {
  access_key = "replacewithmykey"
  secret_key = "repalcewithmykey"
  region     = "us-west-1"
}

# resource "aws_vpc" "myvpc" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "mysubnet" {
#   vpc_id            = aws_vpc.myvpc.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "us-west-1a"
# }

module "vpc" {
  source = "./vpc"
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id
}

module "db" {
  source               = "./db"
  subnet_id            = module.vpc.db_subnet_id
  db_security_group_id = module.vpc.db_security_group_id
}


module "web" {
  source               = "./web"
  subnet_id            = module.vpc.public_subnet_id
  vpc_id               = module.vpc.vpc_id
  db_security_group_id = module.vpc.db_security_group_id
}

output "PrivateIP" {
  value = module.db.PrivateIP
}

output "PublicIP" {
  value = module.web.pub_ip
}
