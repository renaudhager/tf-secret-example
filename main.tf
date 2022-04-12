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
  region  = "eu-west-1"
  profile = "edtech"
}

terraform {
  backend "s3" {
    bucket     = "renaud-terraform-secret-example"
    key        = "state.json"
    region     = "eu-west-1"
    encrypt    = true
    kms_key_id = "arn:aws:kms:eu-west-1:479788333518:key/b7576980-6aba-4758-b014-589eacf0d5bb"
  }
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

output "password_1" {
  value = local.creds.mysecret.password
}

output "password_2" {
  value = local.creds.my2dsecret.password
}
