module "aws_vpc" {
    source = "./modules/aws_vpc"

    for_each = var.vpc_config

    vpc_cidr_block = each.value.vpc_cidr_block

    tags = each.value.tags
  
}

module "aws_subnet" {
    source = "./modules/aws_subnet"

    for_each = var.subnet_config
    availability_zone = each.value.availability_zone
    cidr_block = each.value.cidr_block
    tags = each.value.tags
    vpc_id = module.aws_vpc[each.value.vpc_name].vpc_id
}

module "aws_internet_gateway" {
    source = "./modules/aws_igw"
    for_each = var.awsigwconfig
    vpc_id = module.aws_vpc[each.value.vpc_name].vpc_id
    tags = each.value.tags
}

module "aws_nat_gateway" {

    source = "./modules/aws_ngw"
    for_each = var.nat_gateway_config
    allocation_id = module.aws_eip[each.value.eip_name].aws_eip_id
    subnet_id = module.aws_subnet[each.value.subnet_name].subnet_id
    tags = each.value.tags
}

module "aws_eip" {
    source = "./modules/aws_elastic_ip"
    for_each = var.elastic_ip_config
    tags = each.value.tags
}

module "aws_route_table" {
    source = "./modules/aws_route_table"
    for_each = var.aws_route_table_config
    vpc_id = module.aws_vpc[each.value.vpc_name].vpc_id
    gateway_id = each.value.private == 0 ? module.aws_internet_gateway[each.value.gateway_name].internet_gateway_id : module.aws_nat_gateway[each.value.gateway_name].nat_gateway_id
    tags = each.value.tags 
        
    }
        
  

module "aws_route_table_association" {

    depends_on = [ 
        module.aws_subnet,
        module.aws_route_table
     ]
    source = "./modules/aws_route_association"
    for_each = var.aws_route_table_assoc_config
    subnet_id = module.aws_subnet[each.value.subnet_name].subnet_id
    route_table_id = module.aws_route_table[each.value.route_table_name].route_table_id
 
  
}



