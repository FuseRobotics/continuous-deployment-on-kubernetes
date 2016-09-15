FROM jenkinsci/jnlp-slave
MAINTAINER Vic Iglesias <viglesias@google.com>

ENV NODE_VERSION 6
ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV PATH /opt/google-cloud-sdk/bin:$PATH

#RUN apt-get update -y && \
#    apt-get install -y jq && \
#    curl https://sdk.cloud.google.com | bash && \
#    mv google-cloud-sdk /opt && \
#    gcloud components install kubectl

USER root
ADD entrypoint.bash /

ENV HOME /root
ENV CHROME_BIN chromium

RUN apt-get update && \
    apt-get install -y xvfb chromium && \
    rm -rf /var/lib/apt/lists/*
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.7/install.sh | bash
RUN echo "set +x" | cat - /root/.nvm/nvm.sh > /tmp/out && mv /tmp/out /root/.nvm/nvm.sh

ENV JENKINS k8s
ENTRYPOINT [ "/entrypoint.bash" ]
CMD []
