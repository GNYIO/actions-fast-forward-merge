FROM alpine:3.10

RUN apk update
RUN apk add --no-cache --yes bash git

COPY fast-forward-merge.sh /fast-forward-merge.sh

ENTRYPOINT ["bash", "/fast-forward-merge.sh"]
