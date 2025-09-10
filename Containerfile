FROM scratch AS ctx
COPY / /

FROM quay.io/centos-bootc/centos-bootc:stream9

#setup sudo to not require password
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo

# Write some metadata
RUN echo VARIANT="CoreDNS bootc OS" && echo VARIANT_ID=com.github.caspertdk.homeserver-bootc >> /usr/lib/os-release

# Registry auth
ARG REGISTRY_TOKEN="notset"
ARG REGISTRY_URL="notset"
ARG REGISTRY_USERNAME="someuser"
RUN ln -s /run/user/0/containers/auth.json /etc/ostree/auth.json
RUN echo $REGISTRY_TOKEN | podman login --authfile /etc/ostree/auth.json -u $REGISTRY_USERNAME --password-stdin $REGISTRY_URL

# Install common utilities
RUN dnf -y group install 'Development Tools'
RUN dnf -y install procps-ng curl file qemu-guest-agent git firewalld rsync
# python3-pip

# Configure repositories
RUN dnf -y install 'dnf-command(config-manager)'
RUN dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo

# Install 3rd party software
RUN dnf -y install gh --repo gh-cli

# pip3 dependencies
# RUN pip3 install glances

RUN --mount=type=bind,from=ctx,src=/,dst=/ctx \
    /ctx/build_files/build.sh

# Networking
#EXPOSE 8006
#RUN firewall-offline-cmd --add-port 8006/tcp

# Clean up caches in the image and lint the container
RUN dnf clean all && \
    rm /var/{cache,lib}/dnf /var/lib/rhsm /var/cache/ldconfig -rf 

RUN bootc container lint




