terraform {
  required_providers {
    aws = {
      version = "~> 5.10.0"
    }
  }
}

provider "archive" {}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Production = "False"
      IaC        = "Terraform"
    }
  }
}