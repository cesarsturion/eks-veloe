data "aws_vpc" "vpc" {
  tags = {
    Name = "veloe-vpc"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = "veloe-private-subnet"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = "veloe-public-subnet"
  }
}

data "aws_route_tables" "rts" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = "veloe-route-table-private"
  }
}

data "aws_security_group" "selected" {
  tags = {
    Name = "veloe-private-sec-group"
  }
}
