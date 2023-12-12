resource "aws_instance" "EC2_Instance" {
  ami           = each.value[0] # eu-west-3  ami-06ad2ef8cd7012912,ami-0c6ebbd55ab05f070
  instance_type = "t2.micro"
  availability_zone = each.value[1]
  tags = {
    Name = each.key
    Env = each.value[2]
  }
for_each = {
    vm-001 = ["ami-06ad2ef8cd7012912", "eu-west-3a", "PROD"]
    vm-002 = ["ami-06ad2ef8cd7012912", "eu-west-3b", "UAT"]
    vm-003 = ["ami-0c6ebbd55ab05f070", "eu-west-3c", "DEV"]
}

lifecycle {
    create_before_destroy = true
   # prevent_destroy = true
    #ignore_changes = [tags, ami]
  }
}

data "aws_vpc" "vpc_existing"{
    id = "vpc-015adf10d05067e91"
}

data "aws_subnet" "subnet_existing"{
    id = "subnet-09f7f0a85b9ed570b"
}

resource "aws_network_interface" "private_nic1" {
  subnet_id   = data.aws_subnet.subnet_existing.id
  private_ips = ["192.0.2.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "ec2_static" {
  ami           = "ami-0c6ebbd55ab05f070" # eu-west-3
  instance_type = "t2.micro"
tags = {
    Name = "User19_Static"
    Env = "Prod"
  }
network_interface {
    network_interface_id = aws_network_interface.private_nic1.id
    device_index         = 0
  }

}

/*output "DataSource_VPC" {
    description = "VPC Dump"
    value = data.aws_vpc.vpc_existing
}

output "DataSource_Subnet" {
    description = "Subnet Dump"
    value = data.aws_subnet.subnet_existing
} */