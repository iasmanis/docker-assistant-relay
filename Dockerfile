FROM node:10-alpine


ARG ASSISTANT_RELAY_VERSION=v3.2.0

LABEL build_version="version: ${ASSISTANT_RELAY_VERSION}"
LABEL maintainer="iasmanis"

RUN true && \
    apk add --no-cache wget zip tzdata && \
    wget https://github.com/greghesp/assistant-relay/releases/download/${ASSISTANT_RELAY_VERSION}/release.zip && \
    unzip release.zip -d /assistant-relay && \
    rm -f release.zip && \
    cd /assistant-relay && \
    npm run setup && \
    apk del --purge wget zip && \
    rm -rf /tmp/* /var/cache/apk/* &> /dev/null

VOLUME /assistant-relay/server/configurations/secrets
VOLUME /assistant-relay/server/configurations/tokens
EXPOSE 3000

WORKDIR /assistant-relay
CMD npm run start
