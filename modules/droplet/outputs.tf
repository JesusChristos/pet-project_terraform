output "private_key_pem" {
  value = "${tls_private_key.droplet_ssh_key.private_key_pem}"
}

output "ipv4_address" {
  value       = digitalocean_droplet.openvpn_master.ipv4_address
  description = "The IP of the Droplet."
}