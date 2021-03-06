# Main account config variables
variable "account_token" {}

# Droplet config variables
variable "region" {
    type    = string
    default = "fra1"
}

variable "image_name" {
    type    = string
    default = "ubuntu.16.04"
}

variable "name" {}

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
    default   = "fra1-vpc-01-swarm"
}
variable "ip_range" {
    type      =   string
    default   = "10.10.10.0/24"
}

variable "description" {
    type      = string
    default   = "Subnet for Docker Swarm"
}

variable "lb_name" {
    type      = string
    default   = "fra1-load-balancer-01"
}

variable "lb_region" {
    type      = string
    default   = "fra1"
}

variable "entry_port" {
    type      = number
    default   = 80
}

variable "entry_protocol" {
    type      = string
    default   = "http"
}

variable "target_port" {
    type      = number
    default   = 80
}

variable "target_protocol" {
    type      = string
    default   = "http"
}

variable "port_hck" {
    type      = number
    default   = 22
}

variable "protocol_hck" {
    type      = string
    default   = "tcp"
}