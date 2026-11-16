resource "github_organization_settings" "this" {
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
