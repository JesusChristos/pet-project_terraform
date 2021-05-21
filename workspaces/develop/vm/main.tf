# Provider initialization
terraform {
  required_providers {                                           #https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.5.0"
    }
  }
}

# Cloud Provider
provider "digitalocean" {                                        #https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
  token = var.account_token
}

# Create nodes 
module "droplet" {                                               #https://www.terraform.io/docs/language/modules/syntax.html         
  source = "../../../modules/droplet"
  
  account_token = var.account_token
  image_name    = var.image_name
  name          = var.name
  region        = var.region
  droplet_size  = var.droplet_size
}
