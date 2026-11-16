output "repository_urls" {
  description = "Map of repository name => HTML URL"
  value       = { for name, repo in github_repository.this : name => repo.html_url }
}
