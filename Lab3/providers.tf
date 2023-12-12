terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.8.0"
    }
  }
  backend "s3"{
    bucket = "trainer2022mar121"
    region = "ap-south-1"
    key = "user19_tfstate/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-west-3"
}

provider "aws" {
  alias = "euwest1"
  region = "eu-west-1"
}