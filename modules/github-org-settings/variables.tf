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

  validation {
    condition     = contains(["read", "write", "admin", "none"], var.default_repository_permission)
    error_message = "default_repository_permission must be one of: read, write, admin, none."
  }
}

variable "members_can_create_repositories" {
  description = "Whether organization members can create repositories"
  type        = bool
  default     = false
}
