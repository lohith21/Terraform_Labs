resource "aws_vpc" "main" {
  cidr_block       = "192.0.0.0/16"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "192.0.1.0/24"

  tags = {
    Name = "public"
    env = "Prod"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "192.0.2.0/24"

  tags = {
    Name = "private"
    env = "Prod"
  }
}

resource "aws_subnet" "env" {
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value[0]
  availability_zone = each.value[1]
  for_each = {
      prod = ["192.0.3.0/24", "eu-west-3b"]
      dev =  ["192.0.4.0/24", "eu-west-3c"]
  }
  tags = {
    Name = each.key
  }
}

/*resource "aws_instance" "EC2_Instance" {
  ami           = "ami-0c6ebbd55ab05f070"  # eu west 3 Paris
  instance_type = "t2.micro"
  tags = {
    Name = "User19_VM"
    Env = "Prod"
  }
}*/

output "Public_Subnet_ID" {
    description = "ID of Public Subnet"
    value = aws_subnet.public.id
}

output "Private_Subnet_ID" {
    description = "ID of Private Subnet"
    value = aws_subnet.private.id
}

output "VPC_ID" {
    description = "VPC ID"
    value = aws_vpc.main.id
}
