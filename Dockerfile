FROM alpine:edge

LABEL "com.github.actions.name"="abuilder"
LABEL "com.github.actions.description"=""
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/acj/abuilder"
LABEL "homepage"="http://github.com/acj/abuilder"
LABEL "maintainer"="Adam Jensen <acjensen@gmail.com>"

RUN apk update && \
    apk add --update --no-cache git build-base alpine-sdk && \
    addgroup root abuild

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
