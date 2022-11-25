resource "random_password" "webapi" {
  length  = 16
  special = false
}


resource "postgresql_role" "webapi" {
  name     = "webapi"
  login    = true
  password = random_password.webapi.result
  lifecycle {
    ignore_changes = [
      roles,
    ]
  }
}

resource "postgresql_grant_role" "webapi_read" {
  role       = "webapi"
  grant_role = "pg_read_all_data"
}

resource "postgresql_grant_role" "webapi_write" {
  role       = "webapi"
  grant_role = "pg_write_all_data"
}
