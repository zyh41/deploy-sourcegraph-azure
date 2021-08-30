terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.46.0"
    }
  }
}

provider "azurerm" {
  features {}

  # Auth TF to Azure using service principal and a client secret: https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell-bash?tabs=bash#specify-service-principal-credentials-in-environment-variables
  # OR Azure CLI: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli
  # subscription_id = "<azure_subscription_id>"
  # tenant_id       = "<azure_subscription_tenant_id"
  # client_id       = "<service_principal_appid>"
  # client_secret   = "<service_principal_password>"`
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group["name"]
  location = var.resource_group["location"]
}

resource "azurerm_container_group" "this" {
  name                = var.aci["name"]
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  ip_address_type     = var.aci["ip_address_type"]
  dns_name_label      = var.aci["dns_name_label"]
  os_type             = var.aci["os_type"]
  restart_policy      = "OnFailure"

  container {
    name   = var.aci["container_name"]
    image  = var.aci["image"]
    cpu    = var.aci["cpu"]
    memory = var.aci["memory"]

    ports {
      port     = var.aci["https_port"]
      protocol = var.aci["protocol"]
    }

    ports {
      port     = var.aci["http_port"]
      protocol = var.aci["protocol"]
    }

    volume {
      name = "nginx-config"
      mount_path = "/etc/sourcegraph"
      secret = {
        "sourcegraph.crt" = filebase64("${path.module}/sourcegraph.crt")
        "sourcegraph.key" = filebase64("${path.module}/sourcegraph.key")
        "nginx.conf" = filebase64("${path.module}/nginx.conf")
      }
    }
  }
}
