module "vpc" {
  source = "../../../terraform-vpc-advanced"
   project_name = var.project-name
    cidr_block = var.cidr_block
    common_tags = var.common_tags
    # igw_tags = var.internet_gateway_tags
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    database_subnet_cidr = var.database_subnet_cidr

   # peering_configuration

    Is_peering_required = true
    requestor_id = data.aws_vpc.default.id
    default_route_table_id = data.aws_vpc.default.main_route_table_id
    default_vpc_cidr = data.aws_vpc.default.cidr_block

    } 
