ARG HELM_VERSION
ARG SOPS_VERSION
ARG CLOUDSDK_VERSION=alpine

FROM google/cloud-sdk:$CLOUDSDK_VERSION
ENV HELM_VERSION ${HELM_VERSION:-v3.2.2}
ENV SOPS_VERSION ${SOPS_VERSION:-v3.5.0}
ENV FILENAME helm-${HELM_VERSION}-linux-amd64.tar.gz
ENV HELM_URL https://get.helm.sh/${FILENAME}

RUN apk --update add ca-certificates curl tar gettext \
    && apk add gcc build-base python3-dev libffi-dev openssl-dev \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py \
    && pip install pyopenssl \
    && curl -o /tmp/$FILENAME ${HELM_URL} \
    && tar -zxvf /tmp/${FILENAME} -C /tmp \
    && mv /tmp/linux-amd64/helm /bin/helm \
    && apk add bash git  \
    && curl -sL https://github.com/mozilla/sops/releases/download/$SOPS_VERSION/sops-$SOPS_VERSION.linux > /tmp/sops \
    && mv /tmp/sops /usr/local/bin/sops  \
    && chmod +x /usr/local/bin/sops \
    && rm -rf /tmp \
    && helm plugin install https://github.com/futuresimple/helm-secrets \
    && helm plugin install https://github.com/hayorov/helm-gcs.git \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/$latest_stable/bin/linux/amd64/kubectl -o /usr/bin/kubectl

    