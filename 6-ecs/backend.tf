terraform {
  backend "s3" {
    bucket = "tf-scripts-tennis-jhipster"
    # dynamodb_table = "tf-scripts-jhipster"
    key     = "tfscript-ecs.tf"
    region  = "eu-north-1"
    encrypt = "true"
  }
}
