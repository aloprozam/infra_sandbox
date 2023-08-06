terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.8.0"
    }
  }

  # backend "s3" {
  #   bucket  = "zirconsys-terraform-eu-central-1"
  #   encrypt = true
  #   key     = "aws/dev/terraform-states/terraform.tfstate"
  #   region  = "eu-central-1"
  # }
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "zirconsys"
  region                   = local.region
}
