#!/usr/bin/env bash

set -eou pipefail

# age is an unlikely candidate for EPEL until the Go packaging thing happens
curl -Lo /tmp/age.tar.gz \
    "$(/ctx/build_files/github-release-url.sh FiloSottile/age linux-amd64.tar.gz)"
tar -zxvf /tmp/age.tar.gz -C /usr/bin/ --strip-components=1 --exclude=LICENSE


# kubectl
echo "Installing kubectl"
curl -Lo /tmp/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 /tmp/kubectl /usr/bin/kubectl

# kind
echo "Installing kind"
curl -Lo /tmp/kind \
    "$(/ctx/build_files/github-release-url.sh kubernetes-sigs/kind linux-amd64)"
install -o root -g root -m 0755 /tmp/kind /usr/bin/kind

# fluxcd
echo "Installing flux"
curl -Lo /tmp/flux.tar.gz \
    "$(/ctx/build_files/github-release-url.sh fluxcd/flux2 linux-amd64.tar.gz)"
tar -zxvf /tmp/flux.tar.gz -C /usr/bin/