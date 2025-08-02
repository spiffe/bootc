ARG BASE=test

FROM $BASE

ARG STEP_VER=0.28.4

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y https://dl.smallstep.com/gh-release/cli/gh-release-header/v${STEP_VER}/step-cli-${STEP_VER}-1.$(uname -m).rpm && \
  dnf install -y spiffe-helper spiffe-step-ssh && \
  ( if [ -f /usr/bin/spire-ha-agent ]; then systemctl enable spiffe-step-ssh@a spiffe-step-ssh@b; else systemctl enable spiffe-step-ssh@main; fi; true )
