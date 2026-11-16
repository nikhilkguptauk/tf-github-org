output "team_slugs" {
  description = "Map of team name => team slug"
  value       = { for name, team in github_team.this : name => team.slug }
}

output "team_ids" {
  description = "Map of team name => team ID"
  value       = { for name, team in github_team.this : name => team.id }
}
