resource "github_team" "this" {
  for_each = var.teams

  name        = each.key
  description = each.value.description
  privacy     = each.value.privacy
}

locals {
  # Flatten { team => { user => role } } into one entry per team membership
  memberships = {
    for pair in flatten([
      for team_name, team in var.teams : [
        for username, role in team.members : {
          key      = "${team_name}/${username}"
          team     = team_name
          username = username
          role     = role
        }
      ]
    ]) : pair.key => pair
  }
}

resource "github_team_membership" "this" {
  for_each = local.memberships

  team_id  = github_team.this[each.value.team].id
  username = each.value.username
  role     = each.value.role
}
