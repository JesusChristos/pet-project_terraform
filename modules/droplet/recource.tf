terraform {
  required_providers {                                                                        #https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.5.0"
    }
  }
}

provider "digitalocean" {                                                                     #https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
  token = var.account_token
}

# Create VPC for Droplet
resource "digitalocean_vpc" "subnet-swarm" {                                                  #https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc
  name        = var.vpc_name
  region      = var.region
  ip_range    = var.ip_range
  description = var.description
}

# Create node1
resource "digitalocean_droplet" "node1" {                                                     #https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
  name                = var.name
  image               = var.image_name
  region              = var.region
  size                = var.droplet_size
  vpc_uuid            = digitalocean_vpc.subnet-swarm.id
  ssh_keys            = [digitalocean_ssh_key.master_key.fingerprint]
}

# Create node2
resource "digitalocean_droplet" "node2" {                                                     #https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
  name                = var.name
  image               = var.image_name
  region              = var.region
  size                = var.droplet_size
  vpc_uuid            = digitalocean_vpc.subnet-swarm.id
  ssh_keys            = [digitalocean_ssh_key.master_key.fingerprint]
}

# Create loadbalancer, added nodes
resource "digitalocean_loadbalancer" "swarm-lb" {
  name            = var.lb_name
  region          = var.lb_region
  vpc_uuid        = digitalocean_vpc.subnet-swarm.id 

  forwarding_rule {
    entry_port     = var.entry_port
    entry_protocol = var.entry_protocol

    target_port     = var.target_port
    target_protocol = var.target_protocol
  }

  healthcheck {
    port     = var.port_hck
    protocol = var.protocol_hck
  }

  droplet_ids = [digitalocean_droplet.node1.id]
}



# Build SSH KEY 
resource "tls_private_key" "droplet_ssh_key" {                                                 #https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

#Added ssh key to digitalocean
resource "digitalocean_ssh_key" "master_key" {                                                  #https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/ssh_key
  name       = var.filename
  public_key = "${tls_private_key.droplet_ssh_key.public_key_openssh}"
}

#Write pem key to localfile
resource "local_file" "private_key" {                                                           #https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
    content         = "${tls_private_key.droplet_ssh_key.private_key_pem}"
    filename        = "${path.module}.${var.filename}"
    file_permission = var.file_permission
}

#Write Droplet_IP to localfile node1
resource "local_file" "ipv4_address-node1" {                                                    #https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
    content         = "${digitalocean_droplet.node1.ipv4_address}"
    filename        = "${path.module}.${var.master_ip}-node1.txt"
    file_permission = var.file_permission
}

#Write Droplet_IP to localfile node2
resource "local_file" "ipv4_address-node2" {                                                    #https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
    content         = "${digitalocean_droplet.node2.ipv4_address}"
    filename        = "${path.module}.${var.master_ip}-node2.txt"
    file_permission = var.file_permission
}