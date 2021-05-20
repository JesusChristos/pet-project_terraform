# Main account config variables
variable "account_token" {}

# Droplet config variables
variable "region" {}
variable "name" {}

variable "vpc_name" {
    type      =   string
    default   = "fra1-vpc-01-swarm"
}
variable "ip_range" {}

variable "description" {}