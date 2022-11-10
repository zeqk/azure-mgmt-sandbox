resource "random_password" "webapi" {
  length  = 16
  special = false
}


resource "postgresql_role" "webapi" {
  name     = "webapi"
  login    = true
  password = random_password.webapi.result
}
