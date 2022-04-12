terraform {
  required_version = "0.14.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.33.0"
    }
  }
}

provider "aws" {
  region              = "eu-west-1"
  profile             = "edtech"
}


data "aws_kms_secrets" "creds" {
  secret {
    name    = "credentials"
    payload = file("${path.module}/creds.yaml.encrypted")
  }
}

locals {
  creds = yamldecode(data.aws_kms_secrets.creds.plaintext["credentials"])
}

output "password_1"{
    value = local.creds.mysecret.password
}

output "password_2"{
    value = local.creds.my2dsecret.password
}
