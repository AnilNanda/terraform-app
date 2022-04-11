#!/bin/bash
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum upgrade -y
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

sudo yum install git docker -y

sudo usermod -aG docker jenkins