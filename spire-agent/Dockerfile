ARG BASE=test

FROM docker.io/library/golang:1.24.1 as build

FROM $BASE

RUN \
  set -x && \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y spire-common spire-agent spire-agent-nodeattestor-tpmdirect spire-server-attestor-tpm-verifier spiffe-helper && \
  systemctl enable spire.target spire-agent.target spire-server-attestor-tpm-verifier && \
  ( if ! spire-ha-agent; then systemctl enable spire-agent@main; fi; true )

COPY default.conf /etc/spire/agent/default.conf
