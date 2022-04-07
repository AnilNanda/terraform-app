# module "httpdserver" {
#   source        = ".//httpdserver"
#   instance_type = "t2.micro"
#   vpc_id = module.vpc.vpc_id
#   subnet_id = module.vpc.subnet_id
  
# }

# module "vpc" {
#   source = ".//vpc"
#   vpc_cidr = "10.0.1.0/24"
# }

module "vpc" {
  source  = "app.terraform.io/anilnanda/anil-vpc/aws"
  version = "0.0.1"
  # insert required variables here
  vpc_cidr = "10.0.1.0/24"
}

module "httpdserver" {
  source  = "app.terraform.io/anilnanda/anil-httpd/aws"
  version = "0.0.4"
  # insert required variables here
  instance_type = var.instance_type
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
  public_key = var.public_key
  inbound_ip = var.inbound_ip
}
