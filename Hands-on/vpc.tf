provider "aws" { 
         region = "${var.aws_region}"
}         

# VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block = "${var.vpc_cidr}"
  tags =   {  
     name = "Terraform_VPC"
  }
}
# Internet Gateway
resource "aws_internet_gateway" "terra_igw"  {
    vpc_id = "${aws_vpc.terra_vpc.id}"
    tags =   {
      Name = "main"
    }
}

/** Subnets : public
resource "aws_subnet" "public" {
  count = "${legnth(var.subnets_cidr)}"
  vpc_id = "${aws_vpc.terra_vpc.id}"
  tags = {
    Name = "Subnet-${count.index+1}"
  }
}*/

# Route table: attach Internet Gateway
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.terra_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terra_igw.id}"

  }
}