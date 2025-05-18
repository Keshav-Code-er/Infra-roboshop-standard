terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }


 backend "s3" {
    bucket   = "joindevops-shop1"
    key      = "vpc"
    region   = "us-east-1"
    dynamodb_table = "joindevops-shop-lock1"
  }
}



provider "aws" {
  # Configuration options
  region  = "us-east-1"
}