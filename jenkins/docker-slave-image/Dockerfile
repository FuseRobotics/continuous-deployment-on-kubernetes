# FROM jenkinsci/jnlp-slave:latest
FROM openjdk:8-jdk
MAINTAINER Christian Stewart <christian@paral.in>

RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d /home/jenkins -u 10000 -g 10000 -m jenkins -s /bin/bash

ARG VERSION=2.62

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

# begin stuff
USER root
ADD ./enable-npm-proxy \
    ./init-gce-creds \
    ./upload-cache \
    ./download-cache \
    ./record-cache \
    ./compare-cache \
    ./jenkins-slave \
    /usr/bin/
RUN chmod +x /usr/bin/enable-npm-proxy \
    /usr/bin/init-gce-creds \
    /usr/bin/download-cache \
    /usr/bin/jenkins-slave \
    /usr/bin/upload-cache \
    /usr/bin/compare-cache \
    /usr/bin/record-cache

RUN apt-get update && \
    apt-get install -y xvfb chromium build-essential hashdeep bison pkg-config && \
    rm -rf /var/lib/apt/lists/*

RUN chown -R jenkins:jenkins /home/jenkins
USER jenkins
WORKDIR /home/jenkins

ENV HOME /home/jenkins
ENV CI true
ENV JENKINS k8s
ENV CHROMIUM_BIN /usr/bin/chromium
ENV GO_VERSION 1.7.1

RUN cp ~/.bashrc ~/.bashrc.orig && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.7/install.sh | bash && \
    curl https://sdk.cloud.google.com | bash && \
    mv ~/.bashrc.orig ~/.bashrc && rm ~/.bashrc.backup || true && \
    echo "set +x" >> ~/.bashrc && \
    echo "export NVM_DIR=\"$HOME/.nvm\"" >> ~/.bashrc && \
    echo ". \"\$NVM_DIR/nvm.sh\"" >> ~/.bashrc && \
    echo 'export PATH="$PATH:$HOME/google-cloud-sdk/bin"' >> ~/.bashrc

RUN curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash && \
    bash -c ". ~/.bashrc && . ~/.gvm/scripts/gvm && \
    gvm install go1.4 && \
    gvm use go1.4 && \
    export GOROOT_BOOTSTRAP=$GOROOT && \
    gvm install go${GO_VERSION} && \
    gvm use go${GO_VERSION} --default && \
    gvm uninstall go1.4 && \
    mkdir -p ~/.gvm/pkgsets/go${GO_VERSION}/global/bin && \
    mkdir -p ~/.gvm/pkgsets/go${GO_VERSION}/global/src && \
    curl https://glide.sh/get | sh" && \
    echo "set -x" >> ~/.bashrc

ENTRYPOINT [ "jenkins-slave" ]
CMD []
