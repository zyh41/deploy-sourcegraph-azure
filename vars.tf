
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
    "image" : "sourcegraph/server:3.31.0",
    "cpu" : "2",
    "memory" : "4"
    "https_port" : "443" # aci does not support port mapping https://docs.microsoft.com/en-us/azure/container-instances/container-instances-troubleshooting#container-group-ip-address-may-not-be-accessible-due-to-mismatched-ports
    "http_port" : "80"
    "protocol": "TCP"
  }
}
