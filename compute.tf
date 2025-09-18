### KEY PAIR
#resource "aws_key_pair" "key_pair_lab_devops" {
#  key_name =    = "lab-devops-chave"
#  key_type   = "rsa"
#  private_key = file("~/.ssh/lab-devops-key.pem")
#}

### ELASTIC CONTAINER REGISTRY - ECR
resource "aws_ecr_repository" "lab-devops-ecr" {
  name                 = "lab-devops-repo"
  image_tag_mutability = "MUTABLE"

}

### INSTÂNCIA EC2 - WEBSITE-SERVER 
resource "aws_instance" "website-andrew" {
  ami                         = "ami-08982f1c5bf93d976" # Amazon Linux 2 AMI (HVM), SSD Volume Type - us-east-1
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.lab-devops-subnet-1a.id
  vpc_security_group_ids      = [aws_security_group.sg-lab-devops.id]
  key_name                    = "site-prod"
  associate_public_ip_address = true
  iam_instance_profile        = "ec2-ecr"
  user_data                   = <<-EOF
              #!/bin/bash
              yum upgrade -y && yum update -y
              yum install docker -y
              sudo systemctl start docker
              usermod -aG docker ec2-user
              aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 713881793924.dkr.ecr.us-east-1.amazonaws.com
              EOF

  tags = {
    Name        = "website-server"
    Autor       = "andrew.nogueira"
    Environment = "lab"
    Provisioned = "Terraform"
  }
}