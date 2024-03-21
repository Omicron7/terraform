resource "ansible_host" "app1" {
  name   = "app1"
  groups = ["prod"]
  variables = {
    ansible_host = "127.0.0.1"
  }
}

resource "ansible_host" "app2" {
  name   = "app2"
  groups = ["prod"]
  variables = {
    ansible_host = "127.0.0.1"
  }
}

resource "ansible_group" "linux" {
  name = "prod"
  variables = {
    os           = "linux"
    ansible_user = "root"
  }
}
