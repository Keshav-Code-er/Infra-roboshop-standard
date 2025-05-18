variable "project-name" {
  default = "roboshop-shop"
}

variable "env" {
  default = "dev"
}



variable "common_tags" {
  default = {
    Project     = "roboshop-shop"
    component   = "cart"
    Environment = "DEV"
    terraform   = "true"
  }
}


variable "target_group_port" {
  default = 8080

}

variable "target_group_protocal" {
  default = "HTTP"
}


variable "instance_type" {
  default = "t2.micro"
}

variable "launch_template_tags" {
  default = [
    {
      resource_type = "instance"

      tags = {
        name = "cart"
      }
    },

    {

      resource_type = "volume"
      tags = {
        name = "cart"
      }
    }
  ]
}

variable "auto_scaling_tags" {
  default = [
    {
      key                 = "Name"
      value               = "cart"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "Roboshop"
      propagate_at_launch = true
    }
  ]

}
