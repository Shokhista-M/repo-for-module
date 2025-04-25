terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "029DA-DevOps24"
    
    workspaces {
        prefix = "network-"
    }
  }
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {}

module "iam" {
  source = "./modules/iam"
   read_only = ["read_only_user_1", "read_only_user_2", "read_only_user_3"]
   
}