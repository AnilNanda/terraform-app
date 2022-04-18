terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "anilnanda"
    workspaces {
      name = "terraformProject"
    }
  }
  required_providers {
    ansible = {
      source = "habakke/ansible"
      version = "1.0.10"
    }
  }
}

provider "aws" {
  alias  = "us"
  region = "us-east-1"
}