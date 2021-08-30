output "server_ip" {
  value = "${azurerm_container_group.this.ip_address}"
}

output "fqdn" {
  value = "${azurerm_container_group.this.fqdn}"
}
