FROM node:20

LABEL org.opencontainers.image.title="Compliance Check"
LABEL org.opencontainers.image.description="Run conftest policies"
LABEL org.opencontainers.image.authors="Gus Vega <github.com/gusvega>"

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y wget gnupg curl && rm -rf /var/lib/apt/lists/*

# Install conftest
RUN wget -qO /usr/local/bin/conftest https://github.com/open-policy-agent/conftest/releases/download/v0.52.0/conftest_0.52.0_Linux_x86_64 && chmod +x /usr/local/bin/conftest

WORKDIR /github/workspace

COPY . /action
WORKDIR /action

RUN npm install

ENTRYPOINT ["node", "/action/index.js"]
