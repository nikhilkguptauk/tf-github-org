variable "team_ids" {
  description = "Map of team name => team ID, used to resolve team_access entries"
  type        = map(string)
  default     = {}
}

variable "repositories" {
  description = <<-EOT
    Repositories to create, keyed by repository name.
    team_access maps team name => permission ("pull", "triage", "push", "maintain", "admin").
    Team names must exist in team_ids.
  EOT
  type = map(object({
    description            = optional(string, "")
    visibility             = optional(string, "private")
    has_issues             = optional(bool, true)
    has_wiki               = optional(bool, false)
    auto_init              = optional(bool, true)
    topics                 = optional(list(string), [])
    delete_branch_on_merge = optional(bool, true)
    vulnerability_alerts   = optional(bool, true)
    team_access            = optional(map(string), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for repo in values(var.repositories) : contains(["public", "private", "internal"], repo.visibility)
    ])
    error_message = "Each repository visibility must be \"public\", \"private\" or \"internal\"."
  }

  validation {
    condition = alltrue([
      for repo in values(var.repositories) : alltrue([
        for permission in values(repo.team_access) : contains(["pull", "triage", "push", "maintain", "admin"], permission)
      ])
    ])
    error_message = "Team permissions must be one of: pull, triage, push, maintain, admin."
  }
}
