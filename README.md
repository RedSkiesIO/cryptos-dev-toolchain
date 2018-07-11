## Build standard x86_64 profile.
 sudo apk add debootstrap
 for i in /proc/sys/kernel/grsecurity/chroot_*; do echo 0 | sudo tee $i; done
 mkdir ~/chroot
 sudo debootstrap --arch=i386 wheezy ~/chroot http://http.debian.net/debian/
 for i in /proc/sys/kernel/grsecurity/chroot_*; do echo 1 | sudo tee $i; done
 sudo chroot ~/chroot /bin/bash
 
docker run \
-v `pwd`/_data/abuild:/home/builder/.abuild \
-v `pwd`/cryports:/home/builder/cryports \
-v `pwd`/artifacts/repo/cryptos/:/home/builder/repo/cryptos \
-v `pwd`/artifacts/repo/iso/:/home/builder/iso \
cryptos-dev-toolchain:dev \
sh ./cryports/scripts/mkimage.sh \
--tag edge \
--outdir /home/builder/iso \
--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
--extra-repository http://10.84.172.107 \
--arch armhf \
--profile rpi

sh ./aports/scripts/mkimage.sh \
--tag edge \
--outdir /home/nsh/iso \
--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
--extra-repository http://10.84.172.234:8000/cryptos \
--arch x86_64 \
--profile standard

## Generate Keys

docker run \
-v `pwd`/_data/abuild:/home/builder/.abuild \
alpine-dev-toolchain:dev \
abuild-keygen

## Build csyslinux Package

docker run \
-v `pwd`/_data/abuild:/home/builder/.abuild \
-v `pwd`/cryports/cryptos/cryptos-syslinux:/home/builder/cryptos/src \
-v `pwd`/artifacts/repo:/home/builder/packages/ \
cryptos-dev-toolchain:dev \
sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

## Build crytos-sdk Package

docker run \
-v `pwd`/_data/abuild:/home/builder/.abuild \
-v `pwd`/cryports/cryptos/cryptos-sdk:/home/builder/cryptos/src \
-v `pwd`/artifacts/repo:/home/builder/packages/ \
cryptos-dev-toolchain:dev  \
sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

## Build crytos-baselayout Package

docker run \
-v `pwd`/_data/abuild:/home/builder/.abuild \
-v `pwd`/cryports/cryptos/cryptos-baselayout:/home/builder/cryptos/src \
-v `pwd`/artifacts/repo:/home/builder/packages/ \
cryptos-dev-toolchain:dev \
sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

## Build crytos-base Package

docker run \
-v `pwd`/_data/abuild:/home/builder/.abuild \
-v `pwd`/cryports/cryptos/cryptos-base:/home/builder/cryptos/src \
-v `pwd`/artifacts/repo:/home/builder/packages/ \
cryptos-dev-toolchain:dev \
sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

## build cmkinitfs Package

docker run \
-v `pwd`/_data/abuild:/home/builder/.abuild \
-v `pwd`/cryports/cryptos/cryptos-mkinitfs:/home/builder/cryptos/src \
-v `pwd`/artifacts/repo:/home/builder/packages/ \
--env srcdir=/home/builder/cryptos/src/src \
--env builddir=/home/builder/cryptos/src/mkinitfs-0.0.1 \
cryptos-dev-toolchain:dev \
sh -c "cd cryptos/src && abuild checksum && abuild -R -c"


## Build crytos-conf Package

docker run \
-v `pwd`/_data/abuild:/home/builder/.abuild \
-v `pwd`/cryports/cryptos/cryptos-conf:/home/builder/cryptos/src \
-v `pwd`/artifacts/repo:/home/builder/packages/ \
--env srcdir=/home/builder/cryptos/src/src \
--env builddir=/home/builder/cryptos/src/src/alpine-conf-3.7.0 \
cryptos-dev-toolchain:dev \
sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

## Sign Package

docker run \
-v `pwd`/_data/abuild:/home/builder/.abuild \
-v `pwd`/artifacts/repo/cryptos:/home/builder/packages/ \
cryptos-dev-toolchain:dev \
sh -c "cd /home/builder/packages && apk index -o x86_64/APKINDEX.tar.gz x86_64/*.apk && abuild-sign -k /home/builder/.abuild/james.kirby@atlascityfinace.com-5b1125f6.rsa x86_64/APKINDEX.tar.gz"

docker run \
-v `pwd`/_data/abuild:/home/builder/.abuild \
-v `pwd`/artifacts/repo/cryptos:/home/builder/packages/ \
cryptos-dev-toolchain:dev \
sh -c "cd /home/builder/packages && apk index -o noarch/APKINDEX.tar.gz noarch/*.apk && abuild-sign -k /home/builder/.abuild/james.kirby@atlascityfinace.com-5b1125f6.rsa x86_64/APKINDEX.tar.gz"

