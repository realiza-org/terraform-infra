terraform {
  cloud {
    organization = "realiza-org-terraform"
    workspaces {
      name = "realiza-org-aws-infra"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}