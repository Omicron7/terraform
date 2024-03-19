terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "cru-tf-remote-state"
    dynamodb_table = "terraform-state-lock"
    region         = "us-east-1"
    key            = "spacelift/applications/bar/terraform.tfstate"
  }
}
