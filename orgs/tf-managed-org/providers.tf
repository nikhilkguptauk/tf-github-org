# Token is read from the GITHUB_TOKEN environment variable
provider "github" {
  owner = var.github_org
}
