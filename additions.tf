
resource "aws_subnet" "sock1" {
  vpc_id            = aws_vpc.peer.id
  cidr_block        = "172.31.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "sockshop1"
  }
}

resource "aws_subnet" "socks2" {
  vpc_id            = aws_vpc.peer.id
  cidr_block        = "172.31.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "sockshop2"
  }
}

resource "aws_subnet" "socks3" {
  vpc_id            = aws_vpc.peer.id
  cidr_block        = "172.31.3.0/24"
  availability_zone = "us-west-2c"

  tags = {
    Name = "sockshop3"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.peer.id

  tags = {
    Name = "sockshop"
  }
}


/*
resource "aws_security_group" "sockshop-ec2" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.peer.id

  ingress = [
    {
      description      = "SSH to VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.peer.cidr_block]
      ipv6_cidr_blocks = [aws_vpc.peer.ipv6_cidr_block]
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "sockshop-ec2"
  }
}
*/

resource "aws_route_table" "sockshop" {
  vpc_id = aws_vpc.peer.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  route {
    cidr_block = "172.25.16.0/20"
    gateway_id = aws_vpc.peer.id
  }
  tags = {
    Name = "sockshop"
  }
}

resource "aws_route_table_association" "socks1" {
  subnet_id      = aws_subnet.sock1.id
  route_table_id = aws_route_table.sockshop.id
}

resource "aws_route_table_association" "socks2" {
  subnet_id      = aws_subnet.socks2.id
  route_table_id = aws_route_table.sockshop.id
}

resource "aws_route_table_association" "socks3" {
  subnet_id      = aws_subnet.socks3.id
  route_table_id = aws_route_table.sockshop.id
}

