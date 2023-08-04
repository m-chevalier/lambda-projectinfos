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

data "archive_file" "projectinfos_zip_file" {
  type        = "zip"
  source_file = "projectinfos.py"
  output_path = "projectinfos.zip"
}

// - Policy
data "aws_iam_policy_document" "projectinfo_lambda_policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "projectinfo_lambda_iam" {
  name                  = "limited-projectinfo_lambda_iam"
  //permissions_boundary  = "arn:aws:iam::135225040694:policy/SysopsPermissionsBoundary" 
  assume_role_policy    = data.aws_iam_policy_document.projectinfo_lambda_policy.json
}

data "aws_organizations_organization" "org" {}

resource "aws_lambda_permission" "allow_organization_invoke" {
  statement_id = "AllowOrganizationInvoke"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.project_infos.function_name
  principal = "*"
  principal_org_id = data.aws_organizations_organization.org.id
}

// - Lambda
resource "aws_lambda_function" "project_infos" {
  function_name = var.function_name
  filename      = data.archive_file.projectinfos_zip_file.output_path
  role    = aws_iam_role.projectinfo_lambda_iam.arn
  handler = "projectinfos.lambda_handler"
  runtime = "python3.9"
}