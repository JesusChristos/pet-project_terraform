# Provider initialization
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.5.0"
    }
  }
}

# Cloud Provider
provider "digitalocean" {
  token = var.account_token
}


#module "vpc" {
#  source = "../../../modules/vpc"
#  account_token = var.account_token

#  name        = var.vpc_name
#  region      = var.region
#  ip_range    = var.ip_range
#  description = var.description
#}

# Create  master server
module "droplet" {
  source = "../../../modules/droplet"
  
  account_token = var.account_token
  image_name    = var.image_name
  name          = var.name
  region        = var.region
  droplet_size  = var.droplet_size
}
