terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.5.0"
    }
  }
}

provider "digitalocean" {
  token = var.account_token
}

# Create VPC for Droplet
resource "digitalocean_vpc" "subnet-swarm" {
  name        = var.vpc_name
  region      = var.region
  ip_range    = var.ip_range
  description = var.description
}

# Create node1
resource "digitalocean_droplet" "node1" {
  name                = var.name
  image               = var.image_name
  region              = var.region
  size                = var.droplet_size
  vpc_uuid            = digitalocean_vpc.subnet-swarm.id
  ssh_keys            = [digitalocean_ssh_key.master_key.fingerprint]
}

# Create node2
resource "digitalocean_droplet" "node2" {
  name                = var.name
  image               = var.image_name
  region              = var.region
  size                = var.droplet_size
  vpc_uuid            = digitalocean_vpc.subnet-swarm.id
  ssh_keys            = [digitalocean_ssh_key.master_key.fingerprint]
}

# Build SSH KEY 
resource "tls_private_key" "droplet_ssh_key" {                                                  # https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

#Added ssh key to digitalocean
resource "digitalocean_ssh_key" "master_key" {
  name       = var.filename
  public_key = "${tls_private_key.droplet_ssh_key.public_key_openssh}"
}

#Write pem key to localfile
resource "local_file" "private_key" {
    content         = "${tls_private_key.droplet_ssh_key.private_key_pem}"
    filename        = "${path.module}.${var.filename}"
    file_permission = var.file_permission
}

#Write Droplet_IP to localfile node1
resource "local_file" "ipv4_address-node1" {
    content         = "${digitalocean_droplet.node1.ipv4_address}"
    filename        = "${path.module}.${var.master_ip}-node1.txt"
    file_permission = var.file_permission
}

#Write Droplet_IP to localfile node2
resource "local_file" "ipv4_address-node2" {
    content         = "${digitalocean_droplet.node2.ipv4_address}"
    filename        = "${path.module}.${var.master_ip}-node2.txt"
    file_permission = var.file_permission
}