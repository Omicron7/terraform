resource "ansible_host" "baz" {
  name   = "baz"
  groups = ["stage"]
  variables = {
    ansible_host = "localhost"
  }
}

resource "ansible_group" "stage" {
  name = "stage"
  variables = {
    os           = "linux"
    ansible_user = "root"
  }
}
