terraform {
  required_providers {
    aws = {
      version = "~> 5.10.0"
    }
  }
}

// Archive
provider "archive" {}

// AWS :
provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Production = "False"
      IaC        = "Terraform"
    }
  }
}