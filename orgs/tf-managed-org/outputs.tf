output "org_settings_id" {
  description = "ID of the managed organization settings"
  value       = module.org_settings.id
}

output "team_ids" {
  description = "Map of team name => team ID"
  value       = module.teams.team_ids
}

output "repository_urls" {
  description = "Map of repository name => HTML URL"
  value       = module.repositories.repository_urls
}
