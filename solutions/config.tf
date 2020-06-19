provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket  = "s3-infra-ec1-sh-tfstate-02"
    key     = "xxxx/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
