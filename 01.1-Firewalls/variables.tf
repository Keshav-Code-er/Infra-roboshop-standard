variable "project-name" {
  default = "roboshop-shop"
}

variable "env" {
  default = "dev"
}



variable "common_tags" {
  default = {
    Project     = "roboshop-shop"
    #component  = "firewalls"
    Environment = "DEV"
    terraform   = "true"
  }
}