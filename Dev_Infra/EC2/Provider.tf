
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0"  # Using a minimum version constraint
    }
  }
}

# Cloud Provider
provider "aws" {
  region = "ap-northeast-1"  
} 
