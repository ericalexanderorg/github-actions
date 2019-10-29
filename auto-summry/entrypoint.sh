# Grab the issue body and extract the first URL
GITHUB_ISSUE_BODY=$(jq --raw-output .issue.body "$GITHUB_EVENT_PATH")
URL=$(cat $GITHUB_ISSUE_BODY | grep -o '(http|https)://[^/"]+')

# Get the summary
SUMMRY=$("http://api.smmry.com/&SM_API_KEY=$SUMMRY_API_KEY&SM_URL=$URL" | jq .sm_api_content)

# Add a comment to the issue with the Summry
COMMENTS_URI=$(jq -r ".issue.comments_url" "$GITHUB_EVENT_PATH")
API_HEADER="Accept: application/vnd.github.v3+json"
AUTH_HEADER="Authorization: token $GH_PAT"
new_comment_resp=$(curl --data "{\"body\": \"\The SUMMRY:\n$SUMMRY\"}" -X POST -s -H "${AUTH_HEADER}" -H "${API_HEADER}" ${COMMENTS_URI})

# Following added to actions output for troubleshooting
echo "$new_comment_resp"
echo "created comment"