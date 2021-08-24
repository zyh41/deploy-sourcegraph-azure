# deploy-sourcegraph-azure

This Terraform plan creates a resource group and a container instance with the latest stable version of Sourcegraph in Azure.

## Prerequisities

- [Azure account](https://azure.microsoft.com/en-us/free/)
- [Terraform](https://www.terraform.io/downloads.html)
- [Auth Terraform to Azure using Azure CLI or CloudShell in Azure](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell-bash?tabs=bash#5-authenticate-terraform-to-azure) and/or [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli)

## Commands

1. Clone this repository and initialize Terraform:

```bash
terraform init
```

2. Review the Terraform execution plan:

```bash
terraform plan
```

Example output:

```bash
Terraform used the selected providers to generate thefollowing execution plan. Resource actions are indicated withthe following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_container_group.this will be created
  + resource "azurerm_container_group" "this" {
      + dns_name_label      = "sourcegraph-in-aci"
      + fqdn                = (known after apply)
      + id                  = (known after apply)
      + ip_address          = (known after apply)
      + ip_address_type     = "public"
      + location            = "westus"
      + name                = "sourcegraph-in-aci"
      + os_type             = "Linux"
      + resource_group_name = "my-resource-group"
      + restart_policy      = "OnFailure"

      + container {
          + commands = (known after apply)
          + cpu      = 0.5
          + image    = "sourcegraph/server:3.30.4"
          + memory   = 1.5
          + name     = "sourcegraph"

          + ports {
              + port     = 7080
              + protocol = "TCP"
            }
        }

      + identity {
          + identity_ids = (known after apply)
          + principal_id = (known after apply)
          + type         = (known after apply)
        }
    }

  # azurerm_resource_group.this will be created
  + resource "azurerm_resource_group" "this" {
      + id       = (known after apply)
      + location = "westus"
      + name     = "my-resource-group"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + fqdn      = (known after apply)
  + server_ip = (known after apply)
```

3. Deploy Sourcegraph using Terraform:

```bash
terraform apply
```

Answer 'yes' if asked _Do you want to perform these actions?_

Once it's deployed, you can copy the ouput `server_ip` and `fqdn`:port, paste these into your web browser, and start using Sourcegraph.

![Sourcegraph screenshot](https://user-images.githubusercontent.com/989826/126650657-cef98203-1505-4848-aab6-57acda1ec35f.png)

## Todos:

- Deploy to Azure compute
- HTTPS
- SSH
