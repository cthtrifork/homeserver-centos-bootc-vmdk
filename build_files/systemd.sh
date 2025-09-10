#!/usr/bin/bash

set -ouex pipefail
#systemctl --global enable podman-auto-update.timer
systemctl enable docker.socket
systemctl enable qemu-guest-agent
systemctl enable podman.socket
systemctl enable homer-groups.service
systemctl enable pinggy.service