FROM alpine:3.10

COPY entrypoint.sh /entrypoint.sh
COPY github-sync.sh /github-sync.sh

ENTRYPOINT ["/entrypoint.sh"]