data "spacelift_current_stack" "this" {}
data "spacelift_stack" "this" { stack_id = data.spacelift_current_stack.this.id }
data "spacelift_aws_integration" "aws" { name = "spacelift-role" }

# Create Ansible Stack
resource "spacelift_stack" "ansible" {
  name           = "${data.spacelift_stack.this.name} Ansible"
  space_id       = data.spacelift_stack.this.space_id
  administrative = false
  autodeploy     = false
  project_root   = "/"
  ansible {
    playbook = "playbook.yml"
  }
  repository = "spacelift-ansible"
  branch     = "main"
}

resource "spacelift_aws_integration_attachment" "aws" {
  integration_id = data.spacelift_aws_integration.aws.id
  stack_id       = spacelift_stack.ansible.id
  read           = true
  write          = true
}

resource "spacelift_environment_variable" "terraform_state_key" {
  stack_id = spacelift_stack.ansible.id
  name     = "TERRAFORM_STATE_KEY"
  value    = "applications/ansible-test/terraform.tfstate"
  write_only = true
}
