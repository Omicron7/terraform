data "spacelift_current_stack" "this" {}
data "spacelift_stack" "this" {
  stack_id = data.spacelift_current_stack.this.id
}

# Create Ansible Stack
resource "spacelift_stack" "ansible" {
  name           = "${data.spacelift_stack.this.name} Ansible"
  administrative = false
  autodeploy     = false
  project_root   = "/"
  ansible {
    playbook = "playbook.yml"
  }
  repository = "spacelift-ansible"
  branch     = "main"
}
