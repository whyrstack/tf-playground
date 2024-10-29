terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0" # replace or keep, latest as of 10-2024
    }
  }
}

provider "aws" {
  region  = var.region  # replace or add variables.tf and set name
  profile = var.profile # replace or add variables.tf and set name
}