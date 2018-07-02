FROM alpine:edge

ADD _data/apk/repositories /etc/apk

ADD _data/abuild/james.kirby@atlascityfinace.com-5b1125f6.rsa.pub /etc/apk/keys/james.kirby@atlascityfinace.com-5b1125f6.rsa.pub

RUN apk update

RUN apk --no-cache add coreutils alpine-sdk abuild build-base abuild apk-tools alpine-conf fakeroot syslinux xorriso mtools dosfstools grub-efi

RUN mkdir -p /var/cache/distfiles && \
    adduser -D builder -s /bin/ash && \
    addgroup builder abuild && \
    chgrp abuild /var/cache/distfiles && \
    chmod g+w /var/cache/distfiles && \
    echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

USER builder

WORKDIR /home/builder

ARG startdir
ENV startdir=$startdir

ARG srcdir
ENV srcdir=$srcdir

ARG pkgdir
ENV pkgdir=$pkgdir

ARG pkgver
ENV pkgver=$pkgver

ARG subpkgdir
ENV subpkgdir=$subpkgdir

ARG builddir
ENV builddir=$builddir

ARG arch
ENV arch=$arch
