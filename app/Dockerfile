FROM debian:bookworm-slim

# Pin a release for reproducible builds
ARG CODE_SERVER_VERSION=4.91.1

# Fetch prebuilt code-server, install minimal deps, keep image small
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
 && curl -fsSL https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server-${CODE_SERVER_VERSION}-linux-amd64.tar.gz -o /tmp/cs.tgz \
 && tar -xzf /tmp/cs.tgz -C /opt \
 && mv /opt/code-server-${CODE_SERVER_VERSION}-linux-amd64 /opt/code-server \
 && ln -s /opt/code-server/bin/code-server /usr/local/bin/code-server \
 && apt-get purge -y --auto-remove curl \
 && rm -rf /var/lib/apt/lists/* /tmp/cs.tgz

# Least-privilege runtime user (UID 1000 works well with EFS access points)
RUN useradd -u 1000 -m coder
USER 1000:1000
COPY --chown=1000:1000 demo-project/ /home/coder/project

WORKDIR /home/coder

ENV NODE_ENV=production PORT=8080
EXPOSE 8080

# Password is supplied at runtime via env (PASSWORD or HASHED_PASSWORD)
CMD ["code-server","--auth","password","--bind-addr","0.0.0.0:8080","/home/coder/project"]
