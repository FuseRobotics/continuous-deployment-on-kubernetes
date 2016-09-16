FROM jenkinsci/jnlp-slave:latest
MAINTAINER Vic Iglesias <viglesias@google.com>

USER root
WORKDIR /root
ENV HOME /root
ENV CHROME_BIN chromium
ENV JENKINS k8s

ADD ./enable-npm-proxy.bash /usr/bin/enable-npm-proxy
RUN chmod +x /usr/bin/enable-npm-proxy

RUN apt-get update && \
    apt-get install -y xvfb chromium && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.7/install.sh | bash && \
    echo "set +x" | cat - ~/.nvm/nvm.sh > /tmp/out && mv /tmp/out ~/.nvm/nvm.sh && echo "set -x" >> ~/.nvm/nvm.sh

ENTRYPOINT [ "jenkins-slave" ]
CMD []
