FROM quay.io/centos-bootc/centos-bootc:stream9

#setup sudo to not require password
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo

# Write some metadata
RUN echo VARIANT="CoreDNS bootc OS" && echo VARIANT_ID=com.github.caspertdk.homeserver-bootc >> /usr/lib/os-release

# Install common utilities
RUN dnf -y group install 'Development Tools'
RUN dnf -y install procps-ng curl file qemu-guest-agent git firewalld python3-pip && \
    ln -s ../cloud-init.target /usr/lib/systemd/system/default.target.wants && \
    dnf clean all

# Configure repositories
RUN dnf -y install 'dnf-command(config-manager)'
RUN dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo

# Install 3rd party software
RUN dnf -y install gh --repo gh-cli

# pip3 dependencies
RUN pip3 install glances

# Install 3rd party software directly
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh && rm get-docker.sh

# Enable installed1 software
RUN systemctl enable docker && \
    systemctl enable qemu-guest-agent

# Networking
#EXPOSE 8006
#RUN firewall-offline-cmd --add-port 8006/tcp

# Clean up caches in the image and lint the container
RUN rm /var/{cache,lib}/dnf /var/lib/rhsm /var/cache/ldconfig -rf

RUN bootc container lint




