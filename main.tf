data "template_file" "user_data_jenkins" {
  template = file("./userdata.yml")
}

data "aws_ami" "jenkins_ami" {
  most_recent = true
  owners      = ["137112412989"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220316.0-x86_64*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "terr-buck-xajhab12"
}

resource "aws_instance" "jenkins" {
  instance_type = var.instance_type
  user_data = data.template_file.user_data_jenkins.rendered
  ami = data.aws_ami.jenkins_ami.id
  key_name = "deployer-key"
  subnet_id = module.vpc.subnet_id
  vpc_security_group_ids =  = ["sg-07727d3c3af605739"]
  tags = {
    "Name" = "jenkins"
  }
  depends_on = [
    module.httpdserver
  ]
}
