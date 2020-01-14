#
# Container to use Googles Cloud SDK
#

FROM docker:17.12.0-ce as static-docker-source

FROM alpine:3.10
ARG CLOUD_SDK_VERSION=275.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION

LABEL MAINTAINER="0hlov3s" \
      description="Container to Deploy into GCP"

ARG PACKAGES="bash \
    curl \
    gcc \
    git \
    gnupg \
    jq \
    libtool \
    libffi-dev \
    libc6-compat \
    linux-headers \
    make \
    python3 \
    python3-dev \
    py3-crcmod \
    py3-cryptography \
    openssh-client \
    terraform \
    "
ARG PIP_PACKES="ansible \
    boto3 \
    requests \
    "

ENV PATH /google-cloud-sdk/bin:$PATH
COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker
RUN apk --no-cache add --update $PACKAGES && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade $PIP_PACKES && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    gcloud components install kubectl && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud config set compute/region europe-west3 && \
    gcloud config set compute/region europe-west3 && \
    gcloud --version && \
    kubectl version --client


VOLUME ["/root/.config", "/root/.kube", "/work", "/work/.creds"]
WORKDIR /work

CMD ["/bin/bash"]
