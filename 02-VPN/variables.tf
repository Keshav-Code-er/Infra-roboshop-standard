variable "project-name" {
  default = "roboshop-shop"
}

variable "env" {
  default = "dev"
}



variable "common_tags" {
  default = {
    Project     = "Roboshop-shop"
    component  = "VPN"
    Environment = "DEV"
    terraform   = "true"
  }
}