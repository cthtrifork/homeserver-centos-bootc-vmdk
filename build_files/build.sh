#!/usr/bin/bash
# shellcheck disable=SC1091

set -ouex pipefail

rsync -rvK /ctx/system_files/dx/ /

/ctx/build_files/server-docker-ce.sh
/ctx/build_files/systemd-dx.sh
#/ctx/build_files/cleanup.sh