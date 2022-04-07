terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "anilnanda"
    workspaces {
      name = "dev"
    }
  }
}

provider "aws" {
  alias  = "us"
  region = "us-east-1"
}