/**********************************************************
  # Configure the AWS Provider
  # Add configuration to authorisation keys
  # Configure the AWS Provider
   - required_providers: The required providers for this configuration.
    - source: The source of the provider (hashicorp/aws).
    - version: The version of the provider to use (~> 5.0).
*********************************************************/
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}