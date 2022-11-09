resource "postgresql_extension" "tablefunc" {
  name = "tablefunc"
}

resource "postgresql_extension" "unaccent" {
  name = "unaccent"
}

resource "postgresql_extension" "uuidossp" {
  name = "uuid-ossp"
}