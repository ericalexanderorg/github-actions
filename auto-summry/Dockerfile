FROM alpine:latest

LABEL "com.github.actions.name"="Auto summary of URL in issue"
LABEL "com.github.actions.description"="Auto summary of URL in issue"
LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/ericalexanderorg/github-actions/auto-summry"
LABEL "homepage"="https://github.com/ericalexanderorg/github-actions/auto-summry"
LABEL "maintainer"="Eric Alexander"

RUN apk add --no-cache bash curl jq

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]