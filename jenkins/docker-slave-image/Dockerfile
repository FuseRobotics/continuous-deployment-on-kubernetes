FROM jenkinsci/jnlp-slave:latest
MAINTAINER Vic Iglesias <viglesias@google.com>

USER root
WORKDIR /root

ENV HOME /root
ENV JENKINS k8s
ENV CHROMIUM_BIN /usr/bin/chromium
ENV GO_VERSION 1.7.1

ADD ./enable-npm-proxy \
    ./init-gce-creds \
    ./upload-cache \
    ./download-cache \
    ./record-cache \
    ./compare-cache \
    /usr/bin/
RUN chmod +x /usr/bin/enable-npm-proxy \
    /usr/bin/init-gce-creds \
    /usr/bin/download-cache \
    /usr/bin/upload-cache \
    /usr/bin/compare-cache \
    /usr/bin/record-cache

RUN apt-get update && \
    apt-get install -y xvfb chromium build-essential hashdeep bison && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.7/install.sh | bash && \
    echo "set +x" | cat - ~/.nvm/nvm.sh > /tmp/out && mv /tmp/out ~/.nvm/nvm.sh && echo "set -x" >> ~/.nvm/nvm.sh && \
    curl https://sdk.cloud.google.com | bash && \
    mv ~/.bashrc.backup ~/.bashrc && \
    echo 'export PATH="$PATH:$HOME/google-cloud-sdk/bin"' >> ~/.bashrc

RUN echo "set +x" >> ~/.bashrc && \
    curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash && \
    bash -c ". ~/.bashrc && \
    gvm install go1.4 && \
    gvm use go1.4 && \
    export GOROOT_BOOTSTRAP=$GOROOT && \
    gvm install go${GO_VERSION} && \
    gvm use go${GO_VERSION} --default && \
    gvm uninstall go1.4 && \
    mkdir -p ~/.gvm/pkgsets/go${GO_VERSION}/global/bin && \
    curl https://glide.sh/get | sh" && \
    echo "set -x" >> ~/.bashrc

ENTRYPOINT [ "jenkins-slave" ]
CMD []
