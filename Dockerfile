ARG TF_VERSION=0.12.7

FROM hashicorp/terraform:$TF_VERSION as tf
FROM alpine:3.10.0

# aws-cli
RUN apk --no-cache update && \
    apk --no-cache add bash python py-pip py-setuptools ca-certificates curl less groff && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*

# terraform with tf alias
COPY --from=tf /bin/terraform /usr/bin/terraform
RUN ln -s $(which terraform) /usr/bin/tf
