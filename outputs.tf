output "server_ip" {
  value = "${azurerm_container_group.this.ip_address}:${one(azurerm_container_group.this.container[0].ports).port}"
}

output "fqdn" {
  value = "${azurerm_container_group.this.fqdn}:${one(azurerm_container_group.this.container[0].ports).port}"
}
