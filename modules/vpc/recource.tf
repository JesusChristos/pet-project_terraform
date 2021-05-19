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

resource "digitalocean_vpc" "this" {
  name     = var.vpc_name
  region   = var.region
  ip_range = var.ip_range
}