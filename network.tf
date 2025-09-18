### VPC
resource "aws_vpc" "vpc-lab-devops" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name        = "vpc-lab-devops"
    Autor       = "andrew.nogueira"
    Environment = "lab"
    Provisioned = "Terraform"
  }
}

### INTERNET GATEWAY
resource "aws_internet_gateway" "igw-lab-devops" {
  vpc_id = aws_vpc.vpc-lab-devops.id

  tags = {
    Name        = "igw-lab-devops"
    Autor       = "andrew.nogueira"
    Environment = "lab"
    Provisioned = "Terraform"
  }
}

### SUBNET 1a
resource "aws_subnet" "lab-devops-subnet-1a" {
  vpc_id                  = aws_vpc.vpc-lab-devops.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name        = "subnet-1a-lab-devops"
    Autor       = "andrew.nogueira"
    Environment = "lab"
    Provisioned = "Terraform"
  }
}

### TABELA DE ROTEAMENTO
resource "aws_route_table" "lab-devops-rt" {
  vpc_id = aws_vpc.vpc-lab-devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-lab-devops.id
  }

  tags = {
    Name        = "Tabela de roteamento pública"
    Environment = "Produção"
    Terraform   = "True"
    Autor       = "Andrew Nogueira"
  }
}

### ASSOCIAÇÃO DA TABELA DE ROTEAMENTO COM A SUBNET
resource "aws_route_table_association" "lab-devops-subnet-1a-assoc" {
  subnet_id      = aws_subnet.lab-devops-subnet-1a.id
  route_table_id = aws_route_table.lab-devops-rt.id

}

### SECURITY GROUP
resource "aws_security_group" "sg-lab-devops" {
  name        = "SG-lab-devops"
  description = "Security Group do lab-devops"
  vpc_id      = aws_vpc.vpc-lab-devops.id

  tags = {
    Autor       = "andrew.nogueira"
    Environment = "lab"
    Provisioned = "Terraform"
  }
}

### REGRA DE ENTRADA DO SECURITY GROUP - HTTPS
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.sg-lab-devops.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

### REGRA DE ENTRADA DO SECURITY GROUP -HTTP
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.sg-lab-devops.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

### REGRA DE ENTRADA DO SECURITY GROUP -SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg-lab-devops.id
  cidr_ipv4         = "177.172.96.80/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

### REGRA DE SAÍDA DO SECURITY GROUP - ALL 
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg-lab-devops.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

