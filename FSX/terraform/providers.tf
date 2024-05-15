terraform {
  required_version = ">= 0.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
  }
}

provider "aws" {
  region                   = var.region
  shared_config_files      = var.shared_config_files
  shared_credentials_files = var.shared_credentials_files
}