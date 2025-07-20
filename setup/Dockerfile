ARG BASE=test

FROM $BASE

COPY update-rpi5-dtb /sbin
COPY setup-static-ip /sbin

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y spire-common spire-agent-nodeattestor-tpmdirect spire-server-attestor-tpm-verifier

