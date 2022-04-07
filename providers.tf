terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "anilnanda"
    workspaces {
      name = "terraformProject"
    }
  }
}

provider "aws" {
  alias  = "us"
  region = "us-east-1"
}