    FROM alpine:edge

    ARG ctarget
    ENV CTARGET=$ctarget

    ARG chost
    ENV CHOST=$chost

    ADD _data/apk/repositories /etc/apk

    ADD _data/apk/alpine-devel@lists.alpinelinux.org-524d27bb.rsa.pub /etc/apk/keys

    ADD _data/abuild/james.kirby@atlascityfinace.com-5b1125f6.rsa.pub /etc/apk/keys/james.kirby@atlascityfinace.com-5b1125f6.rsa.pub

    RUN mkdir -p /var/cache/distfiles && \
        adduser -D builder -s /bin/ash && \
        addgroup builder abuild && \
        chgrp abuild /var/cache/distfiles && \
        chmod g+w /var/cache/distfiles && \
        echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
        rm -rf /var/cache/apk/* && \
        rm -rf /tmp/*

    RUN chgrp abuild /etc/apk/keys/james.kirby@atlascityfinace.com-5b1125f6.rsa.pub && \
        chmod g+w /etc/apk/keys/james.kirby@atlascityfinace.com-5b1125f6.rsa.pub

    RUN chgrp -Rf abuild /home/builder && \
        chmod -Rf g+w /home/builder

    RUN apk update

    RUN apk --no-cache add busybox musl crypto++-dev alpine-keys binutils bison flex texinfo zlib-dev squashfs-tools coreutils alpine-sdk abuild build-base abuild apk-tools alpine-conf fakeroot syslinux xorriso mtools dosfstools grub-efi

    RUN ln -s /usr/include/cryptopp /usr/include/crypto++

    RUN ln -s /usr/lib/libcryptopp.so /usr/lib/libcryptopp.so.5.6

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
