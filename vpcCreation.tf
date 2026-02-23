provider "aws" {

    region = "ap-south-1"

  
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "198.16.0.0/24"
  tags = {
    Name = "my_vpc"
  }
  

  enable_dns_hostnames = true
  enable_dns_support = true


}

resource "aws_subnet" "Public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "198.16.0.0/25"
  map_public_ip_on_launch = true
  

  
}

resource "aws_subnet" "Private_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "198.16.0.128/25"
  
  
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}



resource "aws_default_route_table" "my_default_route_table" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }

    tags = {
      Name = "default-route-table"
    }
}








