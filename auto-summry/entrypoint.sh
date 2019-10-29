#!/bin/bash

# Grab the issue body and extract the first URL
GITHUB_ISSUE_BODY=$(jq --raw-output .issue.body "$GITHUB_EVENT_PATH")
URL=$(echo "$GITHUB_ISSUE_BODY" | grep -o '(http|https)://[^/"]+')

# Get the summary
SUMMRY=$(curl -s "http://api.smmry.com/&SM_API_KEY=${SUMMRY_API_KEY}&SM_URL=${URL}" | jq .sm_api_content)
echo "$SUMMRY"

# Add a comment to the issue with the Summry
COMMENTS_URL=$(jq -r ".issue.comments_url" "$GITHUB_EVENT_PATH")
API_HEADER="Accept: application/vnd.github.v3+json"
AUTH_HEADER="Authorization: token $GITHUB_TOKEN"
RESPONSE=$(curl --data "{\"body\": \"${SUMMRY}\"}" -X POST -s -H "${AUTH_HEADER}" -H "${API_HEADER}" "${COMMENTS_URL}")

# Following added to actions output for troubleshooting
echo "$RESPONSE"
echo "created comment"
