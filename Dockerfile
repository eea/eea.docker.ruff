FROM python:3-alpine
MAINTAINER "EEA: IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>

ENV RUFF_VERSION=0.13.3

RUN apk add --no-cache --virtual .run-deps git \
 && pip install ruff==$RUFF_VERSION \
 && mkdir -p /code

COPY ruff.toml /ruff.toml

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ruff"]