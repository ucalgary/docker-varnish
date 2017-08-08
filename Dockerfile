FROM alpine:3.6

ARG VARNISH_VER=5.1.3
ARG VARNISH_URL=http://repo.varnish-cache.org/source/varnish-$VARNISH_VER.tar.gz

RUN apk add --no-cache --virtual .fetch-deps \
        tar
RUN wget -O /tmp/varnish.tar.gz $VARNISH_URL
WORKDIR /tmp/varnish
RUN tar \
        --extract \
        --file "/tmp/varnish.tar.gz" \
        --directory "/tmp/varnish" \
        --strip-components 1
