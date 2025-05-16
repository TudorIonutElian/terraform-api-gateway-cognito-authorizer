/**********************************************************
  # Configure S3 Backend
**********************************************************/

terraform {
  backend "s3" {
    bucket         = "devops-playground-projects-927096366770"
    key            = "terraform-api-gateway-cognito-authorizer-927096366770.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-api-gateway-cognito-authorizer-927096366770"
  }
}