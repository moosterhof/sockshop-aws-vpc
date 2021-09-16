
resource "aws_subnet" "sock1" {
  vpc_id     = aws_vpc.peer.id
  cidr_block = "172.31.1.0/24"
  availability_zone = "us-west-2a"


  tags = {
    Name = "sockshop1"
  }
}

resource "aws_subnet" "socks2" {
  vpc_id     = aws_vpc.peer.id
  cidr_block = "172.31.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "sockshop2"
  }
}

resource "aws_subnet" "socks3" {
  vpc_id     = aws_vpc.peer.id
  cidr_block = "172.31.3.0/24"
  availability_zone = "us-west-2c"

  tags = {
    Name = "sockshop3"
  }
}

