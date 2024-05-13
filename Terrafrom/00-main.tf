module "network" {
  source = "./Network"

  vpc_cidr_block = var.vpc_cidr_block

  subents = {
    pr_subnet_1 = {
      cidr_block              = var.pr_subnet_1["cidr_block"]
      AZ                      = data.aws_availability_zones.available.names[0]
      route_table             = var.pr_subnet_1["route_table"]
      elb                     = "internal-elb"
      map_public_ip_on_launch = false

    }

    pr_subnet_2 = {
      cidr_block              = var.pr_subnet_2["cidr_block"]
      AZ                      = data.aws_availability_zones.available.names[1]
      route_table             = var.pr_subnet_2["route_table"]
      elb                     = "internal-elb"
      map_public_ip_on_launch = false

    }

    pb_subnet_1 = {
      cidr_block              = var.pb_subnet_1["cidr_block"]
      AZ                      = data.aws_availability_zones.available.names[0]
      route_table             = var.pb_subnet_1["route_table"]
      elb                     = "elb"
      map_public_ip_on_launch = true
    }



  }

  route_table = {

    pr_route_table = {
      cidr_block = var.route_cidr_block
      gateway_id = module.network.nat_id
    }

    pb_route_table = {
      cidr_block = var.route_cidr_block
      gateway_id = module.network.gateway_id
    }

  }

  nat_subnet = var.nat_subnet

}

module "security" {
  source = "./Security"
  vpc_id = module.network.vpc_id
}

module "ec2" {
  source = "./Ec2"
  ec2 = {
    pb_ec2 = {
      ami                         = data.aws_ami.ubuntu.id
      instance_type               = var.pb_ec2["instance_type"]
      subnet_id                   = module.network.subnets["pb_subnet_1"]
      associate_public_ip_address = var.pb_ec2["associate_public_ip_address"]
      security_groups             = module.security.security_group
      key_name                    = module.security.key_name
    }
  }
}


module "eks" {
  source         = "./Eks"
  node_subnet    = [module.network.subnets["pb_subnet_1"], module.network.subnets["pr_subnet_1"], module.network.subnets["pr_subnet_2"]]
  cluster_subnet = [module.network.subnets["pr_subnet_1"], module.network.subnets["pr_subnet_2"]]
}
