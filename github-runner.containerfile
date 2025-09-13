RUN mkdir actions-runner && cd actions-runner
RUN curl -o actions-runner-linux-x64-2.328.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.328.0/actions-runner-linux-x64-2.328.0.tar.gz
RUN tar xzf ./actions-runner-linux-x64-2.328.0.tar.gz

# todo inject token
RUN ./config.sh --url https://github.com/cthtrifork/homeserver-centos-bootc --token $TOKEN

# todo move to own service? https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/configure-the-application
$ ./svc.sh install

