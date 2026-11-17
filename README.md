| Feature | Description |
| ------- | ----------- |
| Organization settings | Manages the GitHub org profile (company, location, blog, billing email, description) via the `github-org-settings` module. |
| Default repository permission | Sets the org-wide default permission and whether members can create repositories. |
| Project toggles | Enables or disables organization-level and repository-level projects. |
| Teams | Creates GitHub teams with a description and privacy setting (`closed` or `secret`) via the `github-team` module. |
| Team membership | Adds users to teams as `member` or `maintainer`. |
| Repository creation | Creates repositories with visibility, description, topics, issues, wiki, and auto-init settings via the `github-repository` module. |
| Repository hygiene defaults | Deletes merged branches automatically and enables vulnerability alerts by default. |
| Team access per repository | Grants teams `pull`, `triage`, `push`, `maintain`, or `admin` permission on each repository. |
| JSON repo definitions | Auto-discovers each `orgs/<org>/repos/<name>/repo.json` file and creates that repository on plan. |
| tfvars repo definitions | Accepts repositories in `terraform.tfvars` and merges them with the JSON definitions. |
| Input validation | Rejects invalid visibility, privacy, team role, or permission values at plan time. |
| Multi-org layout | Keeps one root configuration per org under `orgs/`, sharing the same modules in `modules/`. |
| Remote state | Stores each org's state in its own Terraform Cloud workspace (`tf-github-org-<org>`) in local execution mode. |
| Provider version pinning | Pins the GitHub provider to `~> 6.0` and commits `.terraform.lock.hcl` per org. |
| Token handling | Reads the GitHub token from the `GITHUB_TOKEN` environment variable, and git-ignores `*.tfvars` files. |
| Outputs | Exposes the org settings ID, team IDs and slugs, and repository URLs. |
