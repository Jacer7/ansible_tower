provider "aws" {
  region                   = var.aws_region
  # profile                  = "alawme"
  # shared_credentials_files = ["~/.aws/credentials"]
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.0.3"
  backend "s3" {}
}