resource "ansible_host" "app1" {
  name   = "app1"
  groups = ["stage"]
  variables = {
    ansible_host = "127.0.0.1"
  }
}

resource "ansible_host" "app2" {
  name   = "app2"
  groups = ["stage"]
  variables = {
    ansible_host = "127.0.0.1"
  }
}

resource "ansible_host" "app3" {
  name   = "app3"
  groups = ["stage"]
  variables = {
    ansible_host = "127.0.0.1"
  }
}

resource "ansible_group" "linux" {
  name = "stage"
  variables = {
    os           = "linux"
    ansible_user = "root"
  }
}
