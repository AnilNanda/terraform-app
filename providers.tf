terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "anilnanda"
    workspaces {
      name = "terraformProject"
    }
  }
  required_providers {
    ansible = "~> 1.0"
  }
}

provider "aws" {
  alias  = "us"
  region = "us-east-1"
}