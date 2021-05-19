# Main account config variables
variable "account_token" {
    type    = string
    default = "378d542f1fce35f101331ab308cddeb12df45fc2953f72021a1a3dd60e878e9b"
}

# Droplet config variables
variable "region" {
    type    = string
    default = "fra1"
}

variable "image_name" {
    type    = string
    default = "ubuntu.16.04"
}

variable "name" {
    type    = string
    default = "OpenVPN-Master"
}

variable "droplet_size" {
    type    = string
    default = "s-1vcpu-1gb"
}

# Droplet SSH config variables
variable "algorithm" {
    type    = string
    default = "RSA"
}
variable "rsa_bits" {
    type    = string
    default = 4096
}

variable "file_permission" {
    type    = number
    default = 0600
}
variable "filename" {
    type    = string
    default = "master_key"
}

variable "master_ip" {
    type      =   string
    default   = "master_ip"
}
variable "vpc_name" {
    type      =   string
    default   = "subnet_swarm"
}
variable "ip_range" {
    type      = string
    default   = "10.10.10.0/24"
}