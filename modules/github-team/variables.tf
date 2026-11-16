variable "teams" {
  description = <<-EOT
    Teams to create, keyed by team name. Each team may list members as a map of
    GitHub username => role ("member" or "maintainer").
    privacy: "closed" (visible to org members) or "secret" (visible to team members only).
  EOT
  type = map(object({
    description = optional(string, "")
    privacy     = optional(string, "closed")
    members     = optional(map(string), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for team in values(var.teams) : contains(["closed", "secret"], team.privacy)
    ])
    error_message = "Each team privacy must be \"closed\" or \"secret\"."
  }

  validation {
    condition = alltrue([
      for team in values(var.teams) : alltrue([
        for role in values(team.members) : contains(["member", "maintainer"], role)
      ])
    ])
    error_message = "Each team member role must be \"member\" or \"maintainer\"."
  }
}
