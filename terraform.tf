terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }



  backend "s3" {
    bucket = "terraform-bucket-2024"
    key    = "Terra-State/backend/terraform.tfstate"
    region = "us-east-1"
  }
}
