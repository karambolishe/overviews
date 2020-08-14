environment = "test"
kv_tenant_id = "00000000-0000-0000-0000-000000000000"
access_policy_list = {
  "00000000-0000-0000-0000-000000000000" = {
    certificate_permissions = ["backup", "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "recover", "restore", "setissuers", "update"]
    key_permissions         = ["backup", "create", "delete", "get", "import", "list", "recover", "restore", "update"]
    secret_permissions      = ["backup", "delete", "get", "list", "recover", "restore", "set"]
  },
  "00000000-0000-0000-0000-000000000000" = {
    certificate_permissions = ["list"]
    key_permissions         = ["list"]
    secret_permissions      = ["list"]
  }
}

ip_rules_set = [
  "123.123.123.123/32" # home ip
]

home_ip = "123.123.123.123"

user_ids = [
  "00000000-0000-0000-0000-000000000000" # user@extra.com
]

kv_sku_name      = "standard"
location         = "westeurope"
project          = "overviews"
