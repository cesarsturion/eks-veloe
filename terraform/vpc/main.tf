# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "gudiao-labs-tfstates-terraform-veloe-ohio"
    key    = "vpc/terraformt.tfstate"
    region = "us-east-2"
  }
}