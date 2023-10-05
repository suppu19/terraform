terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
  
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = aws_s3_terraformfile
  key    = ".terraform.lock.hcl"
  source = "C:\Users\Vamsikrishna\Desktop\proj\terraform-vpc"  # Local path to your TF file
}