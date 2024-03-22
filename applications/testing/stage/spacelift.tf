data "spacelift_current_stack" "this" {}
data "spacelift_stack" "this" { stack_id = data.spacelift_current_stack.this.id }
data "spacelift_aws_integration" "aws" { name = "spacelift-role" }


resource "spacelift_stack" "this" {
  name                    = data.spacelift_stack.this.name
  space_id                = data.spacelift_stack.this.space_id
  project_root            = data.spacelift_stack.this.project_root
  manage_state            = false
  administrative          = true
  autodeploy              = false
  repository              = "terraform"
  branch                  = "main"
  terraform_workflow_tool = "OPEN_TOFU"
  terraform_version       = "~>1.6.2"
  labels                  = ["nobackend", "feature:add_plan_pr_comment", "terraform", "terraform+ansible"]
}

import {
  id = data.spacelift_current_stack.this.id
  to = spacelift_stack.this
}

locals {
  ansible_branch = "stage-testing"
}

# Create Ansible Stack
resource "spacelift_stack" "ansible" {
  name           = "Ansible (${data.spacelift_stack.this.name})"
  space_id       = data.spacelift_stack.this.space_id
  administrative = false
  autodeploy     = false
  ansible {
    playbook = "playbook.yml"
  }
  repository   = "spacelift-ansible"
  branch       = local.ansible_branch
  labels       = ["ansible", "depends-on:${spacelift_stack.this.id}"]
  runner_image = "public.ecr.aws/y7n4m3q8/spacelift-runner-ansible:latest"
}

resource "spacelift_aws_integration_attachment" "aws" {
  integration_id = data.spacelift_aws_integration.aws.id
  stack_id       = spacelift_stack.ansible.id
  read           = true
  write          = true
}

resource "spacelift_environment_variable" "terraform_state_key" {
  stack_id   = spacelift_stack.ansible.id
  name       = "TERRAFORM_STATE_KEY"
  value      = "spacelift/${data.spacelift_stack.this.project_root}/terraform.tfstate"
  write_only = false
}
