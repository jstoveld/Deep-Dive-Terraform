terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }

  cloud {
    organization = "deep-dive-js"

    workspaces {
      name = "web-network-dev"
    }
  }
}

