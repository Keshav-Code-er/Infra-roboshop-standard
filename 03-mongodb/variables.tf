variable "project-name" {
  default = "roboshop-shop"
}

variable "env" {
  default = "dev"
}



variable "common_tags" {
  default = {
    Project     = "roboshop-shop"
    component  = "mongodb"
    Environment = "DEV"
    terraform   = "true"
  }
}

variable "zone_name" {
  default = "joindevops.shop"
  
}