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

RUN apk add --no-cache --virtual .build-deps \
        gcc \
        libedit-dev \
        linux-headers \
        libexecinfo-dev \
        make \
        musl-dev \
        ncurses-dev \
        patch \
        pcre-dev \
        py-docutils
COPY patches /tmp/varnish/patches/
RUN patch -p1 -l < patches/fix-stack-overflow.patch && \
    patch -p1 -l < patches/musl-mode_t.patch
RUN ./configure \
        --prefix=/usr/local \
        --without-jemalloc
RUN make
