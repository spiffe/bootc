ARG BASE=test

FROM $BASE

COPY setup-tpm /sbin
COPY setup-static-ip /sbin

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y spire-common spire-agent-nodeattestor-tpmdirect spire-server-attestor-tpm-verifier && \
  mkdir -p /etc/spire/server-attestor-tpm/keys && \
  chmod +x /sbin/setup-tpm && \
  chmod +x /sbin/setup-static-ip

