# deploy-sourcegraph-azure

This Terraform plan creates a resource group and a container instance with the latest stable version of Sourcegraph in Azure subcription you specified.

## Prerequisities

- [Azure account](https://azure.microsoft.com/en-us/free/)
- [Terraform](https://www.terraform.io/downloads.html)
- [Auth Terraform to Azure using Azure CLI or CloudShell in Azure](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell-bash?tabs=bash#5-authenticate-terraform-to-azure) and/or [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli)

## Commands

1.

```bash
terraform init
```

2.

```bash
terraform plan
```

example output:

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

3.

```bash
terraform apply
```

and answer 'yes' if asked _Do you want to perform these actions?_

Once its deployed, you can copy the ouput `server_ip` to browser or `fqdn`:port and use Sourcegraph.

## Todos:

- deploy to Azure compute
- HTTPS
- SSH
