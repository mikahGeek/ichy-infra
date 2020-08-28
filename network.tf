## create vpc specifically for ichy resources
resource "aws_vpc" "ichy" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "ichy"
  }
}

## attach vpc to gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ichy.id
}

## subnet the ichy resources (for now just take the full cidr)
resource "aws_subnet" "ichy" {
  vpc_id = aws_vpc.ichy.id
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ichy"
  }
}

## new security group with http and ssh open (todo: fix this!)
resource "aws_security_group" "ichy" {
  name        = "ichy"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

