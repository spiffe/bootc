ARG BASE=test

FROM $BASE
ARG A_PEM=""
ARG B_PEM=""

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y spire-ha-agent && \
  systemctl enable spire-ha-agent@main && \
  systemctl disable spire-agent@main && \
  systemctl enable spire-agent@a && \
  systemctl enable spire-agent@b && \
  mkdir -p /etc/spire/server-attestor-tpm/keys && \
  ( if [ "x${A_PEM}" != "x" ]; then echo "${A_PEM}" | base64 -d > /etc/spire/server-attestor-tpm/keys/a.pem; fi; true ) && \
  ( if [ "x${B_PEM}" != "x" ]; then echo "${B_PEM}" | base64 -d > /etc/spire/server-attestor-tpm/keys/b.pem; fi; true )

COPY simple-verifier.conf /etc/spire/server-attestor-tpm/verifier.conf
