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

module "billing_alert" {
    source = "binbashar/cost-billing-alarm/aws"
    create_sns_topic = true
    aws_env = "029DO-FA24"
    monthly_billing_threshold = 5
    currency = "USD"
}
output "sns_topic_arn" {
    value = "${module.billing_alert.sns_topic_arns}"
}

module "iam" {
  source = "./modules/iam"
   read_only = ["read_only_user_1", "read_only_user_2", "read_only_user_3"]
   
}