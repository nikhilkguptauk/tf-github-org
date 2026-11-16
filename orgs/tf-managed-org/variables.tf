variable "github_org" {
  description = "GitHub organization name to manage"
  type        = string
}

# Organization settings

variable "billing_email" {
  description = "Billing email address for the organization"
  type        = string
}

variable "company" {
  description = "Company name shown on the organization profile"
  type        = string
  default     = null
}

variable "blog" {
  description = "URL shown on the organization profile"
  type        = string
  default     = null
}

variable "description" {
  description = "Organization description"
  type        = string
  default     = null
}

variable "location" {
  description = "Organization location"
  type        = string
  default     = null
}

variable "has_organization_projects" {
  description = "Whether organization-level projects are enabled"
  type        = bool
  default     = false
}

variable "has_repository_projects" {
  description = "Whether repository projects are enabled by default"
  type        = bool
  default     = false
}

variable "default_repository_permission" {
  description = "Base permission members have on org repositories"
  type        = string
  default     = "read"
}

variable "members_can_create_repositories" {
  description = "Whether organization members can create repositories"
  type        = bool
  default     = false
}

# Teams

variable "teams" {
  description = "Teams and their members, see modules/github-team for the schema"
  type = map(object({
    description = optional(string, "")
    privacy     = optional(string, "closed")
    members     = optional(map(string), {})
  }))
  default = {}
}

# Repositories

variable "repositories" {
  description = "Repositories to manage, see modules/github-repository for the schema"
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
}
