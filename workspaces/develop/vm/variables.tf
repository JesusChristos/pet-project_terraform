# Main account config variables
variable "account_token" {}

# Droplet config variables
variable "region" {}
variable "image_name" {}
variable "name" {}
variable "droplet_size" {}


# Droplet SSH config variables
variable "algorithm" {}
variable "rsa_bits" {}
variable "filename" {}
variable "file_permission" {}
variable "master_ip" {}
variable "vpc_name" {}
variable "ip_range" {}
variable "lb_name" {}
variable "lb_region" {}
variable "entry_port" {}
variable "entry_protocol" {}
variable "target_port" {}
variable "target_protocol" {}
variable "port_hck" {}
variable "protocol_hck" {}
