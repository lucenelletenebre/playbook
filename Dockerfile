FROM alpine:3.18.4 AS teleport

WORKDIR /src

COPY teleport-version .

RUN apk --no-cache add curl \
    && curl -o teleport.tar.gz "https://cdn.teleport.dev/teleport-v$(cat teleport-version)-linux-amd64-bin.tar.gz" \
    && tar -xvf teleport.tar.gz

# -------------------------------------------------------------------

FROM python:3.11-slim-bullseye

COPY --from=teleport /src/teleport/tsh /usr/local/bin/

RUN apt-get update \
    && apt-get -y install make jq openssh-client\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir ansible

COPY LICENSE /

WORKDIR /root

CMD ["tail", "-f", "/dev/null"]
# ENTRYPOINT ["/bin/bash"]