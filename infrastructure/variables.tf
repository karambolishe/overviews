variable "project" {
  type    = string
  default = "overviews"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "access_policy_list" {
  type    = map(map(list(string)))
  default = {}
}

variable "ip_rules" {
  type    = list(string)
  default = []
}

variable "home_ip" {
  type    = string
}

variable "user_ids" {
  type = list(string)
  default = []
}

variable "sql_admin" {
  type = string
  default = "karambolishe"
}

variable "ip_rules_set" {
  type = list(string)
  default = []
}