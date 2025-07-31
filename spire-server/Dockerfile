ARG BASE=test

FROM $BASE

COPY usr-share-nginx-html.mount /usr/lib/systemd/system/usr-share-nginx-html.mount
COPY nginx-tmpfiles.conf /usr/lib/tmpfiles.d/nginx-tmpfiles.conf

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y spire-common spire-server spire-controller-manager spire-server-nodeattestor-tpmdirect spire-server-attestor-tpm-sign spire-server-attestor-tpm-signer-http nginx && \
  systemctl enable spire-server.target spire.target && \
  systemctl enable spire-server@main spire-server-attestor-tpm-signer-unix && \
  mkdir -p /etc/spire/server/main/manifests && \
  mv /usr/share/nginx/html /etc/nginx/html && \
  mkdir -p /usr/share/nginx/html && \
  systemctl enable usr-share-nginx-html.mount

COPY nginx-spire.conf /etc/nginx/conf.d/spire.conf
COPY default.conf /etc/spire/server/default.conf
