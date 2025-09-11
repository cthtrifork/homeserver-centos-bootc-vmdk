#!/usr/bin/env bash
set -euo pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

# age is an unlikely candidate for EPEL until the Go packaging thing happens
log "Installing age"
curl -sLo /tmp/age.tar.gz \
    "$(/ctx/build_files/github-release-url.sh FiloSottile/age linux-amd64.tar.gz)"
tar -zxvf /tmp/age.tar.gz -C /usr/bin/ --strip-components=1 --exclude=LICENSE

# kubectl
log "Installing kubectl"
curl -sLo /tmp/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 /tmp/kubectl /usr/bin/kubectl

# kind
log "Installing kind"
curl -sLo /tmp/kind \
    "$(/ctx/build_files/github-release-url.sh kubernetes-sigs/kind linux-amd64)"
install -o root -g root -m 0755 /tmp/kind /usr/bin/kind

# fluxcd
log "Installing flux"
curl -sLo /tmp/flux.tar.gz \
    "$(/ctx/build_files/github-release-url.sh fluxcd/flux2 linux_amd64.tar.gz)"
tar -zxvf /tmp/flux.tar.gz -C /usr/bin/

# k9s
log "Installing k9s"
curl -sLo /tmp/k9s.tar.gz \
    "$(/ctx/build_files/github-release-url.sh derailed/k9s Linux_amd64.tar.gz)"
tar -zxvf /tmp/k9s.tar.gz -C /usr/bin/ --exclude=LICENSE --exclude=README.md
