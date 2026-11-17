#!/usr/bin/env bash
# Trigger a CloudBees CI job through the Jenkins-compatible REST API.
#
# Usage:
#   ./trigger-job.sh <job-name> [KEY=VALUE ...]
#   ./trigger-job.sh my-folder/my-job BRANCH=main DRY_RUN=true
#
# Required environment variables (see .env.example):
#   CB_URL        Controller URL, e.g. https://your-controller.cloudbees.io
#   CB_USER       Your user name on the controller
#   CB_API_TOKEN  API token generated in your user profile
set -euo pipefail

: "${CB_URL:?set CB_URL, e.g. https://your-controller.cloudbees.io}"
: "${CB_USER:?set CB_USER}"
: "${CB_API_TOKEN:?set CB_API_TOKEN}"

JOB="${1:?usage: trigger-job.sh <job-name> [KEY=VALUE ...]}"
shift

# Folder jobs are addressed as /job/<folder>/job/<name>
JOB_PATH="job/$(sed 's#/#/job/#g' <<< "$JOB")"

# Jenkins CSRF crumb. Skipped automatically when the controller has crumbs disabled.
CRUMB_ARGS=()
crumb=$(curl -fsS -u "$CB_USER:$CB_API_TOKEN" "$CB_URL/crumbIssuer/api/json" 2>/dev/null || true)
if [[ -n "$crumb" ]]; then
  field=$(sed -n 's/.*"crumbRequestField":"\([^"]*\)".*/\1/p' <<< "$crumb")
  value=$(sed -n 's/.*"crumb":"\([^"]*\)".*/\1/p' <<< "$crumb")
  CRUMB_ARGS=(-H "$field: $value")
fi

# Any KEY=VALUE arguments become build parameters
PARAM_ARGS=()
for kv in "$@"; do
  PARAM_ARGS+=(--data-urlencode "$kv")
done

if ((${#PARAM_ARGS[@]})); then
  endpoint="buildWithParameters"
else
  endpoint="build"
fi

status=$(curl -sS -o /dev/null -w '%{http_code}' \
  -X POST \
  -u "$CB_USER:$CB_API_TOKEN" \
  ${CRUMB_ARGS[@]+"${CRUMB_ARGS[@]}"} \
  ${PARAM_ARGS[@]+"${PARAM_ARGS[@]}"} \
  "$CB_URL/$JOB_PATH/$endpoint")

# Jenkins answers 201 Created when the build is queued
if [[ "$status" == "201" ]]; then
  echo "Queued: $JOB (HTTP $status)"
else
  echo "Failed to queue $JOB (HTTP $status)" >&2
  exit 1
fi
