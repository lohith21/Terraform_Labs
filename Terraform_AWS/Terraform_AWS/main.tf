provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA2R7IYILCGSRVRAOU"
  secret_key = "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"
}


variable "vpc_cidr_block" {
    description = "Cidr range for VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    default = ["10.0.1.0/24"]
    type = list(string)
}

## 1. Create vpc

resource "aws_vpc" "prod-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "Production"
  }
}


## 2. Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id
}

## Create custom route table

resource "aws_route_table" "prod_route_table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Prod"
  }
}

## Create a subnet

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = var.subnet_cidr[0]
  availability_zone = "us-east-1a"
  tags = {
    Name = "Prod_Subnet"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = var.subnet_cidr[1]
  availability_zone = "us-east-1a"
  tags = {
    Name = "Dev_Subnet"
  }
}

## Associate Subnet with route table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.prod_route_table.id
}

## Create Security Group to allow port 22, 80, 443

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffice"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

 ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

 ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

## Create Network Interface

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet1.id
  private_ips     = ["10.0.200.50"]
  security_groups = [aws_security_group.allow_web.id]

}

## 8. Assign an elastic IP Address

resource "aws_eip" "pip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.200.50"
  depends_on                = [aws_internet_gateway.gw]
}

## 9. Create Ubuntu server and install/enable apache2

resource "aws_instance" "web-server-instance" {
  ami                   = "ami-0fc5d935ebf8bc3bc"
  instance_type         = "t2.micro"
  availability_zone     = "us-east-1a"
  key_name              = "access_key"
  network_interface {
    network_interface_id = aws_network_interface.web-server-nic.id
    device_index         = 0
  }
  tags = {
    Name = "web-server01"
    Flavor = "Ubuntu"
  }
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -update
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo bash -c 'echo your very first web server > /var/www/html/index.html'
              EOF
}


output "server_ips" {
    value = aws_eip.pip.public_ip
}

output "ec2_pvt_ip" {
    value = aws_instance.web-server-instance.private_ip
}