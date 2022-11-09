terraform {
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
    }

  }
}

provider "postgresql" {
  host            = var.server_host
  port            = 5432
  database        = var.database
  username        = var.username
  password        = var.password
  sslmode         = "require"
  connect_timeout = 15
  superuser       = false
}
