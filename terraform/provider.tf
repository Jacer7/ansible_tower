provider "aws" {
  region                   = var.aws_region
  profile                  = "alawme"
  shared_credentials_files = ["~/.aws/credentials"]
}

