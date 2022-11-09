resource "random_password" "a1f_pass" {
  length  = 16
  special = false
}

resource "postgresql_role" "a1f" {
  name     = "a1f"
  login    = true
  password = random_password.a1f_pass.result
}

resource "random_password" "postgres_pass" {
  length  = 16
  special = true
}

resource "postgresql_role" "postgres" {
  name     = "postgres"
  login    = true
  password = random_password.postgres_pass.result
}