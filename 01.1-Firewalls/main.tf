module "vpn_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "roboshop-vpn"
  sg_description = "Allow all port from my home IP"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_vpc.default.id
  common_tags = merge(
    var.common_tags,
    {
      Component = "vpn"
    }
  )
}
module "mongodb_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "mongodb"
  sg_description = "Allow traffic from catalogue and User and VPN"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "mongodb",
      Name      = "mongodb"
    }
  )

}

module "catalogue_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "catalogue"
  sg_description = "Allow traffic from catalogue and User and VPN"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "catalogue",
      Name      = "catalogue"
    }
  )

}

module "web_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "web"
  sg_description = "Allow traffic"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "web",
      Name      = "web"
    }
  )

}

module "app_alb_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "APP-ALB"
  sg_description = "Allow traffic"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "web",
      Name      = "APP-ALB"
    }
  )

}

module "web_alb_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "WEB-ALB"
  sg_description = "Allow traffic"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "web",
      Name      = "WEB-ALB"
    }
  )

}

module "redis_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "redis"
  sg_description = "Allow traffic"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "redis",
      Name      = "redis"
    }
  )

}


module "mysql_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "mysql"
  sg_description = "Allow traffic"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "mysql",
      Name      = "mysql"
    }
  )

}


module "user_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "user"
  sg_description = "Allow traffic"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "user",
      Name      = "user"
    }
  )

}

module "cart_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "cart"
  sg_description = "Allow traffic"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "cart",
      Name      = "cart"
    }
  )

}

module "shipping_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "shipping"
  sg_description = "Allow traffic"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "shipping",
      Name      = "shipping"
    }
  )

}

module "rabbitmq_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "rabbitmq"
  sg_description = "Allow traffic"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "rabbitmq",
      Name      = "rabbitmq"
    }
  )

}

module "payment_sg" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project-name
  sg_name        = "payment"
  sg_description = "Allow traffic"
  #sg_ingress-rule = var.sg_ingress-rule
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "payment",
      Name      = "payment"
    }
  )

}






# this is allowing connection from all catalogue instance to mangodb
resource "aws_security_group_rule" "mongodb_catalogue" {
  type                     = "ingress"
  description              = "Allow port number 27017 from catalogue"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.catalogue_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mongodb_sg.security_Group
}


# thsi allowing traffic from vpn on port no. 22 for troubleshooting 
resource "aws_security_group_rule" "mongodb_vpn" {
  type                     = "ingress"
  description              = "Allow port number 22 from catalogue"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mongodb_sg.security_Group
}

resource "aws_security_group_rule" "mangodb_user" {
  type                     = "ingress"
  description              = "Allow port number 27017 from user"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.user_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mongodb_sg.security_Group
}

resource "aws_security_group_rule" "vpn" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.vpn_sg.security_Group
}

resource "aws_security_group_rule" "catalogue_vpn" {
  type                     = "ingress"
  description              = "Allow port number 22 from VPN"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.catalogue_sg.security_Group
}


resource "aws_security_group_rule" "catalogue_app_alb" {
  type                     = "ingress"
  description              = "Allow port number 8080 from App-ALB"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.catalogue_sg.security_Group
}

resource "aws_security_group_rule" "app_alb_vpn" {
  type                     = "ingress"
  description              = "Allow port number 80 from VPN"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.app_alb_sg.security_Group
}


resource "aws_security_group_rule" "app_alb_web" {
  type                     = "ingress"
  description              = "Allow port number 80 from Web"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.web_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.app_alb_sg.security_Group
}

resource "aws_security_group_rule" "web--vpn" {
  type                     = "ingress"
  description              = "Allow port number 80 from vpn"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_sg.security_Group
}

resource "aws_security_group_rule" "web--vpn_ssh" {
  type                     = "ingress"
  description              = "Allow port number 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_sg.security_Group
}


resource "aws_security_group_rule" "web--public_alb" {
  type                     = "ingress"
  description              = "Allow port number 80 from web--public_alb"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.web_alb_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_sg.security_Group
}

resource "aws_security_group_rule" "public_alb--internet" {
  type        = "ingress"
  description = "Allow port number 80 from public_alb--internet"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_alb_sg.security_Group
}

resource "aws_security_group_rule" "public_alb--internet_https" {
  type        = "ingress"
  description = "Allow port number 443 from public_alb--internet"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_alb_sg.security_Group
}

resource "aws_security_group_rule" "redis_user" {
  type                     = "ingress"
  description              = "Allow port number 6379 from user"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.user_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.redis_sg.security_Group
}

resource "aws_security_group_rule" "redis_cart" {
  type                     = "ingress"
  description              = "Allow port number 6379 from cart"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.cart_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.redis_sg.security_Group
}

resource "aws_security_group_rule" "redis_vpn" {
  type                     = "ingress"
  description              = "Allow port number 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.redis_sg.security_Group
}

resource "aws_security_group_rule" "user_app_alb" {
  type                     = "ingress"
  description              = "Allow port number 8080 from App ALb"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.user_sg.security_Group
}

resource "aws_security_group_rule" "user_vpn" {
  type                     = "ingress"
  description              = "Allow port number 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.user_sg.security_Group
}

# resource "aws_security_group_rule" "mangodb_user" {
#   type                     = "ingress"
#   description              = "Allow port number 22 from mongodb"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   source_security_group_id = module.user_sg.security_Group
#   #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.mongodb_sg.security_Group
# }

resource "aws_security_group_rule" "cart_app_alb" {
  type                     = "ingress"
  description              = "Allow port number 8080 from App ALb"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.cart_sg.security_Group
}

resource "aws_security_group_rule" "cart_vpn" {
  type                     = "ingress"
  description              = "Allow port number 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.cart_sg.security_Group
}

resource "aws_security_group_rule" "mysql_vpn" {
  type                     = "ingress"
  description              = "Allow port number 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mysql_sg.security_Group
}

resource "aws_security_group_rule" "mysql_shipping" {
  type                     = "ingress"
  description              = "Allow port number 3306 from shipping"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.shipping_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mysql_sg.security_Group
}

resource "aws_security_group_rule" "shipping_vpn" {
  type                     = "ingress"
  description              = "Allow port number 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.shipping_sg.security_Group
}

resource "aws_security_group_rule" "shipping_app_alb" {
  type                     = "ingress"
  description              = "Allow port number 8080 from App ALb"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.shipping_sg.security_Group
}

resource "aws_security_group_rule" "rabbitmq_vpn" {
  type                     = "ingress"
  description              = "Allow port number 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.rabbitmq_sg.security_Group
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  type                     = "ingress"
  description              = "Allow port number 5672 from payment"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  source_security_group_id = module.payment_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.rabbitmq_sg.security_Group
}

resource "aws_security_group_rule" "payment_vpn" {
  type                     = "ingress"
  description              = "Allow port number 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.payment_sg.security_Group
}

resource "aws_security_group_rule" "payment_app_alb" {
  type                     = "ingress"
  description              = "Allow port number 8080 from App ALb"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.security_Group
  #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.payment_sg.security_Group
}


