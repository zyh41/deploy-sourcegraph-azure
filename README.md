# deploy-sourcegraph-azure

This Terraform plan creates a resource group and a container instance with the latest stable version of Sourcegraph in Azure subcription you specified.

## Prerequisities

- [Azure account](https://azure.microsoft.com/en-us/free/)
- [Terraform](https://www.terraform.io/downloads.html)
- [Auth Terraform to Azure using Azure CLI or CloudShell in Azure](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell-bash?tabs=bash#5-authenticate-terraform-to-azure) and/or [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli)

- [openssl](https://www.openssl.org/) or [mkcert](https://github.com/FiloSottile/mkcert) to generate self signed certificates for HTTPS.

## Commands

0. Generating a self signed cert using openssl

```bash
openssl req -new -newkey rsa:2048 -nodes -keyout sourcegraph.key -out sourcegraph.csr -config openssl.conf
```

This will created a private key and a certificate signing request using [openssl.conf](./openssl.conf).

```bash
# generate and sign cert using private key and config file from above
openssl x509 -req -days 365 -in sourcegraph.csr -signkey sourcegraph.key -out sourcegraph.crt -extfile openssl.conf -extensions req_ext
```

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
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
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
          + cpu      = 2
          + image    = "sourcegraph/server:3.31.0"
          + memory   = 4
          + name     = "sourcegraph"

          + ports {
              + port     = 443
              + protocol = "TCP"
            }
          + ports {
              + port     = 80
              + protocol = "TCP"
            }

          + volume {
              + empty_dir  = false
              + mount_path = "/etc/sourcegraph"
              + name       = "nginx-config"
              + read_only  = false
              + secret     = (sensitive value)
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

Once its deployed, you can copy the output `server_ip` or `fqdn` to browser and use Sourcegraph.

4.  Use

```bash
terraform destroy
```

To destroy the instance.

## Todos:

- deploy to Azure compute
- ~~HTTPS~~
- SSH
