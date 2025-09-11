#!/usr/bin/env bash
set -euo pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

ARCH="amd64"
MACHINE="linux"

log "Installing age"
curl -sLo /tmp/age.tar.gz \
    "$(/ctx/build_files/github-release-url.sh FiloSottile/age ${MACHINE}-${ARCH}.tar.gz)"
tar -zxvf /tmp/age.tar.gz -C /usr/bin/ --strip-components=1 --exclude=LICENSE

log "Installing kubectl"
curl -sLo /tmp/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/${MACHINE}/${ARCH}/kubectl"
install -o root -g root -m 0755 /tmp/kubectl /usr/bin/kubectl

log "Installing kubelogin"
curl -sLo /tmp/kubelogin.zip \
    "$(/ctx/build_files/github-release-url.sh int128/kubelogin ${MACHINE}.${ARCH}.zip)"
unzip /tmp/kubelogin.zip -d /usr/bin/ -x "LICENSE" "README.md"

log "Installing kind"
curl -sLo /tmp/kind \
    "$(/ctx/build_files/github-release-url.sh kubernetes-sigs/kind ${MACHINE}.${ARCH})"
install -o root -g root -m 0755 /tmp/kind /usr/bin/kind

log "Installing flux"
curl -sLo /tmp/flux.tar.gz \
    "$(/ctx/build_files/github-release-url.sh fluxcd/flux2 ${MACHINE}.${ARCH}.tar.gz)"
tar -zxvf /tmp/flux.tar.gz -C /usr/bin/

log "Installing kustomize"
curl -sLo /tmp/kustomize.tar.gz \
    "$(/ctx/build_files/github-release-url.sh kubernetes-sigs/kustomize ${MACHINE}.${ARCH}.tar.gz)"
tar -zxvf /tmp/kustomize.tar.gz -C /usr/bin/

log "Installing k9s"
curl -sLo /tmp/k9s.tar.gz \
    "$(/ctx/build_files/github-release-url.sh derailed/k9s ${MACHINE}.${ARCH}.tar.gz)"
tar -zxvf /tmp/k9s.tar.gz -C /usr/bin/ --exclude=LICENSE --exclude=README.md

log "Installing sops"
curl -sLo /tmp/sops \
    "$(/ctx/build_files/github-release-url.sh getsops/sops ${MACHINE}.${ARCH})"
install -o root -g root -m 0755 /tmp/sops /usr/bin/sops

log "Installing jq"
curl -sLo /tmp/jq \
    "$(/ctx/build_files/github-release-url.sh jqlang/jq ${MACHINE}.${ARCH})"
install -o root -g root -m 0755 /tmp/jq /usr/bin/jq

log "Installing yq"
curl -sLo /tmp/yq \
    "$(/ctx/build_files/github-release-url.sh mikefarah/yq ${MACHINE}.${ARCH})"
install -o root -g root -m 0755 /tmp/yq /usr/bin/yq

log "Installing helm"
curl -sLo /tmp/helm.tar.gz "https://get.helm.sh/$(curl -L -s https://get.helm.sh/helm-latest-version)-${MACHINE}-${ARCH}.tar.gz"
tar -zxvf /tmp/helm.tar.gz.gz -C /usr/bin/ --strip-components=1 --exclude=LICENSE --exclude README.md