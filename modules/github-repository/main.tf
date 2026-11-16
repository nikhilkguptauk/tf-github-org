resource "github_repository" "this" {
  for_each = var.repositories

  name                   = each.key
  description            = each.value.description
  visibility             = each.value.visibility
  has_issues             = each.value.has_issues
  has_wiki               = each.value.has_wiki
  auto_init              = each.value.auto_init
  topics                 = each.value.topics
  delete_branch_on_merge = each.value.delete_branch_on_merge
  vulnerability_alerts   = each.value.vulnerability_alerts
}

locals {
  # Flatten { repo => { team => permission } } into one entry per team grant
  team_grants = {
    for pair in flatten([
      for repo_name, repo in var.repositories : [
        for team_slug, permission in repo.team_access : {
          key        = "${repo_name}/${team_slug}"
          repository = repo_name
          team       = team_slug
          permission = permission
        }
      ]
    ]) : pair.key => pair
  }
}

resource "github_team_repository" "this" {
  for_each = local.team_grants

  team_id    = var.team_ids[each.value.team]
  repository = github_repository.this[each.value.repository].name
  permission = each.value.permission
}
