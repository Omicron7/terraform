terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "cru-tf-remote-state"
    dynamodb_table = "terraform-state-lock"
    region         = "us-east-1"
    key            = "applications/ansible-test/terraform.tfstate"
  }
  required_providers {
    ansible = {
      source  = "ansible/ansible"
      version = "~> 1.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30"
    }
    spacelift = {
      source = "spacelift-io/spacelift"
      version = "1.10.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Name        = "ansible-test"
      application = "ansible-test"
      managed_by  = "terraform"
      owner       = "devops-engineering-team@cru.org"
      terraform   = replace(abspath(path.root), "/^.*/(cru-terraform|default)/", "")
    }
  }
}
