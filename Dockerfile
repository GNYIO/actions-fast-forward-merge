FROM alpine:3.10

RUN apk update && apk add bash

COPY fast-forward-merge.sh /fast-forward-merge.sh

ENTRYPOINT ["bash", "fast-forward-merge.sh"]
