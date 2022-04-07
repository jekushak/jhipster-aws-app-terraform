# AWS Credentials
#variable "AWS_ACCESS_KEY" {}
#variable "AWS_SECRET_KEY" {}
#variable "region" {
#  default = "eu-north-1"
#}

#Codebuild
variable "artifact" {
  description = "Populates the Artifact block"
  default = {
    packaging      = "NONE"
    namespace_type = "NONE"
  }
}
variable "sourcecode" {
  type = map(any)
  default = {
    type      = "CODECOMMIT"
    location  = "tennisapp-jhipster"
    buildspec = "buildspec-docker.yml"
  }
}
variable "container_port" {
  default = "8080"
}

#Codedeploy
variable "compute_platform" {
  type    = string
  default = "ECS"
}
variable "ecs_cluster_name" {
  type    = string
  default = "ecs-tennis-dev-cluster-slp"
}
variable "ecs_service_name" {
  type    = string
  default = "ecs-tennis-dev-service-slp"
}
variable "listener_arn" {
  type    = string
  default = ""
}
variable "alb_target_group_arn" {
  type = list(string)
  default = [
    "target-gr-tennis-dev-slp-1",
    "target-gr-tennis-dev-slp-2"
  ]
}
#Codepipeline
variable "bucketname" {
  default = ""
}
variable "artifact_type" {
  description = "The Artifact type, S3, CODEPIPELINE or NO_ARTIFACT"
  type        = string
  default     = "S3"
}



