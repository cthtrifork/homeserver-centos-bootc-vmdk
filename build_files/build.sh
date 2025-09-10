#!/usr/bin/bash
# shellcheck disable=SC1091

set -ouex pipefail

rsync -rvpK /ctx/system_files/ /

mkdir -p /run/metadata/
echo "PINGGY_TOKEN=$PINGGY_TOKEN" > /run/metadata/pinggy

/ctx/build_files/github-cli.sh
/ctx/build_files/server-docker-ce.sh
/ctx/build_files/utilities.sh
/ctx/build_files/systemd.sh
#/ctx/build_files/cleanup.sh