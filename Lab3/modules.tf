module ec2 {
    source = "./modules/"
    ec2 = "VM-UBU-001"
}

/*module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

# VPC Basic Details
  name = "vpc-dev"
  cidr = "172.0.0.0/16"   

  azs                 = ["eu-west-3a", "eu-west-3b"]
  private_subnets     = ["172.0.1.0/24", "172.0.2.0/24"]
  public_subnets      = ["172.0.101.0/24", "172.0.102.0/24"]

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = true

tags = {
    Owner = "lohith"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }
}
  
  

  # Database Subnets
  create_database_subnet_group = true
  create_database_subnet_route_table= true
  database_subnets    = ["10.0.151.0/24", "10.0.152.0/24"]

  #create_database_nat_gateway_route = true
  #create_database_internet_gateway_route = true


  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

}*/