FROM alpine:latest
LABEL maintainer docker@katagena.com
LABEL org.label-schema.vcs-url="https://github.com/nouchka/docker-gandi-mail"
LABEL version="latest"

ENV GANDI_API_KEY=TATAYOYO
ENV GANDI_DOMAIN=example.com

COPY generate.sh /generate.sh

RUN mkdir -p /usr/src/app && apk update && apk add jq && apk add curl diffutils && chmod +x /generate.sh
WORKDIR /usr/src/app


ENTRYPOINT /generate.sh
