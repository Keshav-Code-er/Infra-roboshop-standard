variable "project-name" {
  default = "roboshop-shop"
}

variable "env" {
  default = "dev"
}



variable "common_tags" {
  default = {
    Project     = "roboshop-shop"
    component   = "web"
    Environment = "DEV"
    terraform   = "true"
  }
}

#web 
variable "health_check" {
  default = {
    enabled             = true
    healthy_threshold   = 2 #consider as healthy checks are success
    interval            = 15
    matcher             = "200-299"
    path                = "/"
    port                = 80 #only for web 
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3

  }

}

variable "target_group_port" {
  default = 80

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
        name = "web"
      }
    },

    {

      resource_type = "volume"
      tags = {
        name = "web"
      }
    }
  ]
}

variable "auto_scaling_tags" {
  default = [
    {
      key                 = "Name"
      value               = "web"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "Roboshop"
      propagate_at_launch = true
    }
  ]

}
