ARG BASE=test

FROM $BASE

ARG STEP_VER=0.28.7

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y https://dl.smallstep.com/gh-release/cli/gh-release-header/v${STEP_VER}/step-cli-${STEP_VER}-1.$(uname -m).rpm && \
  dnf install -y spiffe-helper spiffe-step-ssh && \
  (echo 'SPIFFE_STEP_SSH_PORT=7443'; echo 'SPIFFE_STEP_SSH_FETCHCA_PORT=5443') > /etc/spiffe/step-ssh/default.env && \
  ( if [ -f /usr/bin/spire-ha-agent ]; then systemctl enable spiffe-step-ssh@a spiffe-step-ssh@b; else systemctl enable spiffe-step-ssh@main; fi; true )
