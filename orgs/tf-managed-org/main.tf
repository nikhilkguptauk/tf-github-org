module "org_settings" {
  source = "../../modules/github-org-settings"

  billing_email                   = var.billing_email
  company                         = var.company
  blog                            = var.blog
  description                     = var.description
  location                        = var.location
  has_organization_projects       = var.has_organization_projects
  has_repository_projects         = var.has_repository_projects
  default_repository_permission   = var.default_repository_permission
  members_can_create_repositories = var.members_can_create_repositories
}

module "teams" {
  source = "../../modules/github-team"

  teams = var.teams
}

locals {
  # Each folder under repos/ defines one repository in repos/<name>/repo.json
  repo_folders = {
    for file in fileset(path.module, "repos/*/repo.json") :
    basename(dirname(file)) => jsondecode(file("${path.module}/${file}"))
  }
}

module "repositories" {
  source = "../../modules/github-repository"

  repositories = merge(var.repositories, local.repo_folders)
  team_ids     = module.teams.team_ids
}
