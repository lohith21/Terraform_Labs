resource "aws_instance" "EC2_Instance" {
  ami           = data.aws_ami.ami_latest.id # eu west 3 Paris
  instance_type = "t2.micro"
  tags = {
    Name = var.ec2
    Env = "Prod"
  }
}