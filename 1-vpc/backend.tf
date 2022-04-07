terraform {
  backend "s3" {
    bucket  = "tf-scripts-tennis-jhipster"
    key     = "tfscript-vpc.tf"
    region  = "eu-north-1"
    encrypt = "true"
  }
}

