variable "project-name" {
  default = "roboshop-shop"

}
variable "env" {
  default = "dev"
}

variable "cidr_block" {
  default = "10.0.0.0/16"

}

variable "common_tags" {
  default = {
    Project     = "Roboshop-shop"
    component   = "vpc"
    Environment = "DEV"
    terraform   = "true"
  }
}

variable "internet_gateway_tags" {
  default = {
    Name = "roboshop_igw"
  }

}

variable "public_subnet_cidr" {
  default = ["10.0.0.0/24", "10.0.2.0/24"]

}

variable "private_subnet_cidr" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]

}

variable "database_subnet_cidr" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]

}

