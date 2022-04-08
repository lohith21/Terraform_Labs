/* variable "env" {
   type = string
}

resource "aws_instance" "ec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = count
   count = var.env == prod ? t2.micro : t2.small
}

resource "aws_instance" "dev" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
   count = var.instance_type == false ? 1 : 0
}

resource "aws_instance" "prod" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.small"
   count = var.instance_type == true ? 1 : 0
}*/