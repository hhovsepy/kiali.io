FROM registry.fedoraproject.org/fedora-minimal

ARG HUGO_VERSION

VOLUME /site
WORKDIR /site

# Download, untar, and install Hugo
RUN microdnf -y install tar shadow-utils git nodejs \
 && microdnf clean all

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz /hugo.tar.gz
RUN tar xzvf /hugo.tar.gz -C / \
 && rm /hugo.tar.gz \
 && mv /hugo /usr/bin/hugo

# Stuff for docsy
RUN npm -g -D install postcss postcss-cli autoprefixer
RUN npm prune

# Confirm hugo binary is available and show its version
RUN hugo version
