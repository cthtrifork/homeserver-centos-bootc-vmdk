#!/usr/bin/env bash

set -eou pipefail

# age is an unlikely candidate for EPEL until the Go packaging thing happens
curl -Lo /tmp/age.tar.gz \
    "$(/ctx/build_files/github-release-url.sh FiloSottile/age linux-amd64.tar.gz)"
tar -zxvf /tmp/age.tar.gz -C /usr/bin/ --strip-components=1 --exclude=LICENSE