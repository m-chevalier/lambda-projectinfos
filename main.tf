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

data "archive_file" "code" {
  type        = "zip"
  source_dir  = "${path.module}/code"
  output_path = "${path.module}/projectinfos.zip"
}

// - Policy document for the lambda
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

// role of the lambda
resource "aws_iam_role" "projectinfo_lambda_iam" {
  name                  = "projectinfo_lambda_iam"
  assume_role_policy    = data.aws_iam_policy_document.projectinfo_lambda_policy.json
}

data "aws_organizations_organization" "org" {}

// - Permissions for the lambda
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
  filename         = data.archive_file.code.output_path
  source_code_hash = data.archive_file.code.output_base64sha256
  role    = aws_iam_role.projectinfo_lambda_iam.arn
  handler = "projectinfos.lambda_handler"
  runtime = "python3.9"
}