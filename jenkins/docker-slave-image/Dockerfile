FROM jenkinsci/jnlp-slave:latest
MAINTAINER Vic Iglesias <viglesias@google.com>

USER root
WORKDIR /root
ENV HOME /root
ENV JENKINS k8s
ENV CHROMIUM_BIN /usr/bin/chromium

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
    apt-get install -y xvfb chromium build-essential hashdeep && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.7/install.sh | bash && \
    echo "set +x" | cat - ~/.nvm/nvm.sh > /tmp/out && mv /tmp/out ~/.nvm/nvm.sh && echo "set -x" >> ~/.nvm/nvm.sh && \
    curl https://sdk.cloud.google.com | bash && \
    mv ~/.bashrc.backup ~/.bashrc && \
    echo 'export PATH="$PATH:$HOME/google-cloud-sdk/bin"' >> ~/.bashrc

ENTRYPOINT [ "jenkins-slave" ]
CMD []
