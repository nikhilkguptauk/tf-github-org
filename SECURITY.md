# Security Policy

## Reporting a vulnerability

Do not open a public issue for a security problem. Report it privately through
GitHub's private vulnerability reporting: open the **Security** tab of this
repository and choose **Report a vulnerability**.

Include the affected file or module, the steps to reproduce, and the impact you
expect. You can expect an acknowledgement within a few working days.

## Scope

This repository contains Terraform code that manages GitHub organization
settings, teams, and repositories. It must never contain credentials. Report any
committed token, key, `*.tfvars` file, or Terraform state as a vulnerability.

## Handling credentials

- Provide the GitHub token through the `GITHUB_TOKEN` environment variable only.
- Keep real values in `terraform.tfvars` or `*.auto.tfvars`. Both are git-ignored.
- Terraform state lives in Terraform Cloud, not in this repository.
