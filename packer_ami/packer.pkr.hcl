variable "source_ami" {
  type    = string
  default = "ami-0c02fb55956c7d316"
}

source "amazon-ebs" "httpd" {
  ami_name              = "httpd"
  instance_type         = "t2.micro"
  region                = "us-east-1"
  source_ami            = var.source_ami
  force_deregister      = true
  force_delete_snapshot = true
  ssh_username          = "ec2-user"
  tags = {
    "Name" = "httpd"
  }
}

source "amazon-ebs" "jenkins" {
  ami_name              = "jenkins"
  instance_type         = "t2.micro"
  region                = "us-east-1"
  source_ami            = var.source_ami
  force_deregister      = true
  force_delete_snapshot = true
  ssh_username          = "ec2-user"
  tags = {
    "Name" = "jenkins"
  }
}

build {
  sources = ["source.amazon-ebs.httpd"]
  provisioner "ansible" {
    playbook_file = "./httpd.yml"
  }
#  provisioner "shell" {
#    script = "installhttpd.sh"
#  }
#  provisioner "file" {
#    source      = "index.html"
#    destination = "/home/ec2-user/"
#  }
#  provisioner "shell" {
#    inline = ["sudo cp -rf /home/ec2-user/index.html /var/www/html/"]
#  }

}

build {
  sources = ["source.amazon-ebs.jenkins"]
  provisioner "shell" {
    script = "installjenkins.sh"
  }
}