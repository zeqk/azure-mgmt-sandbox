output "a1f_password" {
  value = random_password.a1f_pass.result
  sensitive = true
}

output "postgres_password" {
  value = random_password.postgres_pass.result
  sensitive = true
}