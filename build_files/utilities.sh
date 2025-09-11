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
    "$(/ctx/build_files/github-release-url.sh FiloSottile/age linux-amd64.tar.gz)"
tar -zxvf /tmp/age.tar.gz -C /usr/bin/ --strip-components=1 --exclude=LICENSE

log "Installing kubectl"
curl -sLo /tmp/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 /tmp/kubectl /usr/bin/kubectl

log "Installing kubelogin"
curl -sLo /tmp/kind \
    "$(/ctx/build_files/github-release-url.sh int128/kubelogin ${MACHINE}_${ARCH}.zip)"
tar -zxvf /tmp/flux.tar.gz -C /usr/bin/

log "Installing kind"
curl -sLo /tmp/kind \
    "$(/ctx/build_files/github-release-url.sh kubernetes-sigs/kind linux-amd64)"
install -o root -g root -m 0755 /tmp/kind /usr/bin/kind

log "Installing flux"
curl -sLo /tmp/flux.tar.gz \
    "$(/ctx/build_files/github-release-url.sh fluxcd/flux2 linux_amd64.tar.gz)"
tar -zxvf /tmp/flux.tar.gz -C /usr/bin/

log "Installing k9s"
curl -sLo /tmp/k9s.rpm \
    "$(/ctx/build_files/github-release-url.sh derailed/k9s Linux_amd64.rpm)"
#tar -zxvf /tmp/k9s.tar.gz -C /usr/bin/ --exclude=LICENSE --exclude=README.md
dnf install /tmp/k9s.rpm

log "Installing sops"
curl -sLo /tmp/sops \
    "$(/ctx/build_files/github-release-url.sh getsops/sops linux.amd64)"
install -o root -g root -m 0755 /tmp/sops /usr/bin/sops

log "Installing jq"
curl -sLo /tmp/jq \
    "$(/ctx/build_files/github-release-url.sh jqlang/jq linux-amd64)"
install -o root -g root -m 0755 /tmp/jq /usr/bin/jq

log "Installing yq"
curl -sLo /tmp/yq \
    "$(/ctx/build_files/github-release-url.sh mikefarah/yq linux_amd64)"
install -o root -g root -m 0755 /tmp/yq /usr/bin/yq
