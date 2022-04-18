data "template_file" "user_data_jenkins" {
  template = file("./userdata.yml")
}

data "aws_ami" "jenkins_ami" {
  most_recent = true
  owners      = ["435122781463"]
  filter {
    name   = "name"
    values = ["jenkins"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "httpd_ami" {
  most_recent = true
  owners      = ["435122781463"]
  filter {
    name   = "name"
    values = ["httpd"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# resource "aws_s3_bucket" "bucket" {
#   bucket = "terr-buck-xajhab12"
# }

resource "aws_instance" "jenkins" {
  instance_type          = var.instance_type
  user_data              = data.template_file.user_data_jenkins.rendered
  ami                    = data.aws_ami.jenkins_ami.id
  key_name               = "deployer-key"
  subnet_id              = module.vpc.subnet_id
  vpc_security_group_ids = ["sg-07727d3c3af605739"]
  provisioner "ansible" {
    playbook_file = "/httpd.yml"

  }
  tags = {
    "Name" = "jenkins"
  }
  depends_on = [
    module.httpdserver
  ]
}

resource "aws_instance" "httpd" {
  instance_type = var.instance_type
  #user_data = data.template_file.user_data_jenkins.rendered
  #ami                    = data.aws_ami.httpd_ami.id
  ami                    = "ami-0c02fb55956c7d316"
  key_name               = "deployer-key"
  subnet_id              = module.vpc.subnet_id
  vpc_security_group_ids = ["sg-07727d3c3af605739"]
  tags = {
    "Name" = "httpd"
  }
  depends_on = [
    module.httpdserver
  ]
}
