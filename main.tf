resource "aws_vpc" "adr_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "adr_public_subnet" {
  vpc_id                  = aws_vpc.adr_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "dev-public"
  }
}

resource "aws_internet_gateway" "adr_internet_gateway" {
  vpc_id = aws_vpc.adr_vpc.id

  tags = {
    Name = "dev-gateway"
  }

}

resource "aws_route_table" "adr_public_rt" {
  vpc_id = aws_vpc.adr_vpc.id

  tags = {
    Name = "dev-routetable"
  }
}

resource "aws_route" "adr_default_route" {
  route_table_id         = aws_route_table.adr_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.adr_internet_gateway.id

}

resource "aws_route_table_association" "adr_rta" {
  subnet_id      = aws_subnet.adr_public_subnet.id
  route_table_id = aws_route_table.adr_public_rt.id
}

resource "aws_security_group" "adr_sg" {
  name        = "dev_sg"
  description = "Dev security group"
  vpc_id      = aws_vpc.adr_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_cidr_block
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "adr_auth" {
    key_name = var.key_name
    public_key = file(var.public_key_path)
  
}

resource "aws_instance" "dev_node" {
    instance_type = "t2.micro"
    ami = data.aws_ami.server_ami.id
    key_name = aws_key_pair.adr_auth.id
    vpc_security_group_ids = [ aws_security_group.adr_sg.id ]
    subnet_id = aws_subnet.adr_public_subnet.id
    user_data = templatefile("userdata.tftpl",{})

    root_block_device {
      volume_size = 10
    }

    tags = {
      Name = "dev-node"
    }
    
}