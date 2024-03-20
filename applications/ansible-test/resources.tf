resource "ansible_host" "foo" {
  name   = "foo"
  groups = ["linux"]
  variables = {
    os           = "linux"
    ansible_host = "127.0.0.1"
  }
}

resource "ansible_host" "bar" {
  name   = "bar"
  groups = ["linux"]
  variables = {
    os           = "linux"
    ansible_host = "127.0.0.1"
  }
}

resource "ansible_host" "baz" {
  name   = "baz"
  groups = ["windows"]
  variables = {
    os           = "windows"
    ansible_host = "127.0.0.1"
  }
}

resource "ansible_group" "linux" {
  name = "linux"
  variables = {
    ansible_user = "root"
  }
}
