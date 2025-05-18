variable "project-name" {
  default = "roboshop-shop"
}

variable "env" {
  default = "dev"
}



variable "common_tags" {
  default = {
    Project     = "roboshop-shop"
    component  = "web-alb"
    Environment = "DEV"
    terraform   = "true"
  }
}