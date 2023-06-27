region     = "us-east-1"
access_key = "******************"
secret_key = "***************************"

vpc_config = {

    vpc01 = {
        vpc_cidr_block = "192.168.0.0/16"

        tags = {
            "Name" = "myvpc"
        }
    }
}

subnet_config = {

    "public-us-east-1a" = {

        vpc_name = "vpc01"

        cidr_block = "192.168.0.0/18"
        availability_zone = "us-east-1a"
        tags = {
            "Name" = "public-us-east-1a"
        }

    }

    "public-us-east-1b" = {

        vpc_name = "vpc01"

        cidr_block = "192.168.64.0/18"
        availability_zone = "us-east-1b"
        tags = {
            "Name" = "public-us-east-1b"
        }

    }

    "private-us-east-1c" = {

        vpc_name = "vpc01"

        cidr_block = "192.168.128.0/18"
        availability_zone = "us-east-1c"
        tags = {
            "Name" = "private-us-east-1c"
        }

    }

    "private-us-east-1b" = {

        vpc_name = "vpc01"

        cidr_block = "192.168.192.0/18"
        availability_zone = "us-east-1b"
        tags = {
            "Name" = "private-us-east-1b"
        }

    }
}

awsigwconfig = {
    igw01 = {
        vpc_name = "vpc01"
        tags = {
            "Name" = "My_IGW"
        }

    }

    }


aws_route_table_config = {

    RT01 = {
        private = 0
        vpc_name = "vpc01"
        gateway_name = "igw01"
        tags = {
            Name = "Public-route"
        }

    }

    RT02 = {
        private = 1
        vpc_name = "vpc01"
        gateway_name = "natgw01"
        tags = {
            Name = "Private-route"
        }

    }
        

    RT03 = {
        private = 1
        vpc_name = "vpc01"
        gateway_name = "natgw02"
        tags = {
            Name = "Private-route"
        }

    }
}

elastic_ip_config = {
    eip01 ={
        tags = {
            "Name" = "nat01"
        }
    }

    eip02 ={
        tags = {
            "Name" = "nat02"
        }
    }

}

nat_gateway_config = {

    natgw01 = {
        eip_name = "eip01"
        subnet_name = "public-us-east-1a"
        tags = {
            "Name" = "natgw01"
        }
    }

    natgw02 = {
        eip_name = "eip02"
        subnet_name = "public-us-east-1b"
        tags = {
            "Name" = "natgw02"
    }

    }
}


        

aws_route_table_assoc_config = {

    RT01ssocname = {
        subnet_name = "public-us-east-1a"
        route_table_name = "RT01"
        
    }

    RT02ssocname = {
        subnet_name = "public-us-east-1a"
        route_table_name = "RT01"
        
    }

    RT03ssocname = {
        subnet_name = "private-us-east-1b"
        route_table_name = "RT02"
        
    }
    RT04ssocname = {
        subnet_name = "private-us-east-1c"
        route_table_name = "RT03"
        
    }

}
