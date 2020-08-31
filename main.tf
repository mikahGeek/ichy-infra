provider "aws" {
  profile = "infra"
  region = "us-east-2"
}

resource "aws_instance" "first" {
  ami = "ami-0bbe28eb2173f6167"
  key_name = "ec2-key"
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  instance_type = "t2.micro"
##  subnet_id = aws_subnet.ichy.id
##  security_groups = [aws_security_group.ichy.id]
}

resource "aws_eip" "lb" {
  instance = aws_instance.first.id
  vpc      = true
}
