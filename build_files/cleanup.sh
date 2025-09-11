#!/usr/bin/bash
#shellcheck disable=SC2115

set -eou pipefail

dnf clean all

# Removes all files in /tmp and everything under /var (logs, caches, lockfiles, etc.).
rm -rf /tmp/*
rm -rf /var/*
mkdir -p /tmp
mkdir -p /var/tmp && chmod -R 1777 /var/tmp