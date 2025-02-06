resource "azurerm_web_application_firewall_policy" "jiri" {
  name                = "ajirimcitwaf"
  resource_group_name = "mcit_resource_group_ajiri"
  location            = "canadacentral"

  custom_rules {
    name      = "BlockSQLInjection"
    priority  = 1
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable = "RequestHeader"
        selector = "User-Agent"
      }
      operator = "Contains"
      values    = ["SQLmap"]
    }

    action = "Block"
  }

  # Default action for WAF policy
  default_action {
    action_type = "Block"
  }

  # Rules to handle
  managed_rules {
    managed_rule_set {
      rule_set_type = "OWASP"
      rule_set_version = "3.2"
    }
  }
