terraform {
  required_version = ">= 1.5.0"

  # State: Terraform Cloud workspace for this org (Execution Mode = Local)
  cloud {
    organization = "nikhilkgupta"

    workspaces {
      name = "tf-github-org-tf-managed-org"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
