# tf-github-org

Terraform code to manage GitHub organizations. Each org has its own folder, state, and set of teams and repositories. Reusable building blocks live in `modules/`.

## Layout

```
modules/                        Reusable building blocks (no backend, no provider config)
  github-org-settings/          Organization profile and default permissions
  github-team/                  Teams and team memberships
  github-repository/            Repositories and team access
orgs/
  <org-name>/                   One root configuration per GitHub org
    versions.tf                 Backend: Terraform Cloud workspace tf-github-org-<org-name>
    providers.tf                GitHub provider for this org
    main.tf                     Calls the modules for this org
    variables.tf
    outputs.tf
    terraform.tfvars.example    Copy to terraform.tfvars and fill in
```

Each org folder keeps its own state in its own Terraform Cloud workspace, so orgs cannot lock or overwrite each other.

## Prerequisites

- Terraform >= 1.5
- For each org, a Terraform Cloud workspace named `tf-github-org-<org-name>`, created as **CLI-driven workflow** with **Execution Mode = Local**
- `terraform login` run once on your machine
- A GitHub token with org admin scope for each org, exported locally:
  ```
  export GITHUB_TOKEN=<token>
  ```

## Setup for a new org

1. Copy `orgs/tf-managed-org/` to `orgs/<org-name>/`.
2. In `orgs/<org-name>/versions.tf`, replace `YOUR-TFC-ORG` with your Terraform Cloud organization name and change the workspace name to `tf-github-org-<org-name>`.
3. Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in the values. `*.tfvars` files are git-ignored.

## Running

```
cd orgs/<org-name>
terraform init
terraform plan
terraform apply
```

### Adding a repository

Create a folder under the org's `repos/` directory, named after the repository, with a `repo.json` file:

```
orgs/<org-name>/repos/<repo-name>/repo.json
```

```json
{
  "description": "Test repository managed by tf-github-org",
  "visibility": "public",
  "topics": ["terraform", "test"],
  "team_access": { "platform": "maintain" }
}
```

Every `repos/*/repo.json` is picked up automatically on `terraform plan`. Repositories can also be declared in `terraform.tfvars` under `repositories`; both sources are merged.

Team access in `repositories` refers to teams by name (the keys of `teams`), so a team must be defined in the same tfvars file before it is used.

## Adding a new module

1. Put reusable resources in `modules/<name>/` with `versions.tf`, `main.tf`, `variables.tf`, and `outputs.tf`.
2. Call the module from each `orgs/<org-name>/main.tf` that needs it and add its inputs to that folder's `variables.tf`.

Commit `.terraform.lock.hcl` in each org folder so provider versions stay pinned.
