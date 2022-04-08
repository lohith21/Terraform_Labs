resource "aws_instance" "myvm01" {
  ami           = "ami-0c6ebbd55ab05f070"
  instance_type = "t2.micro"
tags = {
  Name = local.name
  env = "Prod"
  owner = var.owner
}
}