output "private_key_pem" {
  value = "${tls_private_key.droplet_ssh_key.private_key_pem}"
}

# Write IP to localfile node1
output "ipv4_address-node1" {
  value       = digitalocean_droplet.node1.ipv4_address
  description = "The IP of the Droplet."
}

# Write IP to localfile node2
output "ipv4_address-node2" {
  value       = digitalocean_droplet.node2.ipv4_address
  description = "The IP of the Droplet."
}