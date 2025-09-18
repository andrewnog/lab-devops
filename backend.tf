# Salvar tfstate no S3
terraform {
  backend "s3" {
    bucket  = "lab-devops-terraform-state"
    key     = "lab-devops/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true

    tags = {
      Autor       = "andrew.nogueira"
      Environment = "lab"
      Provisioned = "Terraform"
    }
  }
}