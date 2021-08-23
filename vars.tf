
# Set default values or override from tfvars

variable "resource_group" {
  default = {
    "name" : "my-resource-group"
    "location" : "westus"
  }
}

variable "aci" {
  default = {
    "name" : "sourcegraph-in-aci"
    "ip_address_type" : "public",
    "dns_name_label" : "sourcegraph-in-aci",
    "os_type" : "Linux"
    "container_name" : "sourcegraph"
    "image" : "sourcegraph/server:3.30.4",
    "cpu" : "0.5",
    "memory" : "1.5"
    "port" : "7080" # aci does not support port mapping https://docs.microsoft.com/en-us/azure/container-instances/container-instances-troubleshooting#container-group-ip-address-may-not-be-accessible-due-to-mismatched-ports
  }
}
