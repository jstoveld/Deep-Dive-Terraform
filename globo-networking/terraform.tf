terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }

  cloud {
    # Update this with your actual Terraform Cloud organization name
    organization = "deep-dive-js"

    workspaces {
      # Update this with your desired workspace name
      name = "globo-networking"
    }
  }
}

