ARG BASE=test

FROM $BASE

ARG STEP_VER=0.28.7
ARG STEPCA_VER=0.28.4
ARG YQ_VER=4.47.1

COPY setup-tpm /sbin
COPY setup-static-ip /sbin

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y https://dl.smallstep.com/gh-release/certificates/gh-release-header/v${STEPCA_VER}/step-ca-${STEPCA_VER}-1.$(uname -m).rpm && \
  dnf install -y https://dl.smallstep.com/gh-release/cli/gh-release-header/v${STEP_VER}/step-cli-${STEP_VER}-1.$(uname -m).rpm && \
  dnf install -y spire-common spire-agent-nodeattestor-tpmdirect spire-server-attestor-tpm-verifier spiffe-step-ssh-server && \
  curl -L https://github.com/mikefarah/yq/releases/download/v${YQ_VER}/yq_linux_arm64 -o /usr/bin/yq && \
  chmod 755 /usr/bin/yq && \
  mkdir -p /etc/spire/server-attestor-tpm/keys && \
  chmod +x /sbin/setup-tpm && \
  chmod +x /sbin/setup-static-ip

