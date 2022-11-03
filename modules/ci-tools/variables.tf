variable "env" {
  type = object({
    abbreviation = string
    name         = string
  })
}

variable "location" {
  type = object({
    abbreviation = string
    name         = string
  })
}

variable "rgName" {
  type    = string
  default = ""
}

variable "subscription_id" {
  type    = string
  default = "00000000-0000-0000-0000-000000000000"
}
variable "tenant_id" {
  type    = string
  default = "00000000-0000-0000-0000-000000000000"
}

