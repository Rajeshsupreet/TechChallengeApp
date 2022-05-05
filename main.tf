data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.location
}

resource "azurerm_postgresql_server" "DatabaseServer" {
  name                = var.postgresql-server-name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled = true
  ssl_enforcement_enabled       = "false"
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"

  administrator_login          = var.administratorlogin
  administrator_login_password = var.administratorloginpassword
}

resource "azurerm_postgresql_database" "database" {
  name                = var.postgresql-db-name
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.DatabaseServer.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "rule" {
  name                = "acctest-PSQL-firewall-rule"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.DatabaseServer.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_app_service_plan" "service-plan" {
  name                = var.service-plan-name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  kind                = "Linux"
  reserved            = true
  zone_redundant      = "false"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = var.appname
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_app_service_plan.service-plan.location
  app_service_plan_id = azurerm_app_service_plan.service-plan.id
  https_only          = "true"

  site_config {
    always_on        = "true"
    linux_fx_version = "DOCKER|${var.docker_image}"
    app_command_line = "updatedb -s && serve"
  }

  lifecycle {
    ignore_changes = [
      site_config.0.linux_fx_version,
      site_config.0.app_command_line
    ]
  }

  app_settings = {
    VTT_DBUSER                 = "${var.administratorlogin}@${var.postgresql-server-name}"
    VTT_DBPASSWORD             = var.administratorloginpassword
    VTT_DBHOST                 = azurerm_postgresql_server.DatabaseServer.fqdn
    VTT_DBNAME                 = var.postgresql-db-name
    VTT_LISTENPORT             = "80"
    VTT_LISTENHOST             = var.listenhost
    VTT_DBPORT                 = "5432"
    WEBSITES_PORT              = "80"
    DOCKER_REGISTRY_SERVER_URL = "https://index.docker.io"
    PGSSLMODE                  = "require"
  }

  logs {
    application_logs {
      file_system_level = "Verbose"
    }
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }

  depends_on = [
    azurerm_postgresql_firewall_rule.rule
  ]
}
