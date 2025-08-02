ARG BASE=test

FROM $BASE

ARG STEP_VER=0.28.4
ARG YQ_VER=4.47.1

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y https://dl.smallstep.com/gh-release/certificates/gh-release-header/v${STEP_VER}/step-ca-${STEP_VER}-1.$(uname -m).rpm && \
  dnf install -y spiffe-helper && \
  curl https://github.com/mikefarah/yq/releases/download/v${YQ_VER}/yq_linux_arm64 -o /usr/bin/yq && \
  chmod 755 /usr/bin/yq && \
  mkdir -p /etc/spiffe/step-ssh/server/main
