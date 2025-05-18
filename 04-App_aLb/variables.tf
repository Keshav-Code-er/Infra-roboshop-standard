variable "project-name" {
  default = "roboshop-shop"
}

variable "env" {
  default = "dev"
}



variable "common_tags" {
  default = {
    Project     = "roboshop-shop"
    component  = "App-ALB"
    Environment = "DEV"
    terraform   = "true"
  }
}