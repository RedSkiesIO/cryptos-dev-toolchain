.PHONY: build-repo
build-repo: build-csyslinux build-sdk build-baselayout build-base build-cmkinitfs build-conf

.PHONY: sign-x8664
sign-x8664: sign-x8664

.PHONY: sign-noarch
sign-noarch: sign-noarch

.PHONY: sign-all
sign-all: sign-x8664 sign-noarch

build-container:
	docker build . --tag cryptos-dev-toolchain:dev

build-csyslinux:
	docker run \
	-v `pwd`/_data/abuild:/home/builder/.abuild \
	-v `pwd`/cryports/cryptos/cryptos-syslinux:/home/builder/cryptos/src \
	-v `pwd`/artifacts/repo:/home/builder/packages/ \
	cryptos-dev-toolchain:dev \
	sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

build-sdk:
	docker run \
	-v `pwd`/_data/abuild:/home/builder/.abuild \
	-v `pwd`/cryports/cryptos/cryptos-sdk:/home/builder/cryptos/src \
	-v `pwd`/artifacts/repo:/home/builder/packages/ \
	cryptos-dev-toolchain:dev  \
	sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

build-baselayout:
	docker run \
	-v `pwd`/_data/abuild:/home/builder/.abuild \
	-v `pwd`/cryports/cryptos/cryptos-baselayout:/home/builder/cryptos/src \
	-v `pwd`/artifacts/repo:/home/builder/packages/ \
	cryptos-dev-toolchain:dev \
	sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

build-base:
	docker run \
	-v `pwd`/_data/abuild:/home/builder/.abuild \
	-v `pwd`/cryports/cryptos/cryptos-base:/home/builder/cryptos/src \
	-v `pwd`/artifacts/repo:/home/builder/packages/ \
	cryptos-dev-toolchain:dev \
	sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

build-cmkinitfs:
	docker run \
	-v `pwd`/_data/abuild:/home/builder/.abuild \
	-v `pwd`/cryports/cryptos/cryptos-mkinitfs:/home/builder/cryptos/src \
	-v `pwd`/artifacts/repo:/home/builder/packages/ \
	--env srcdir=/home/builder/cryptos/src/src \
	--env builddir=/home/builder/cryptos/src/mkinitfs-0.0.1 \
	cryptos-dev-toolchain:dev \
	sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

build-conf:
	docker run \
	-v `pwd`/_data/abuild:/home/builder/.abuild \
	-v `pwd`/cryports/cryptos/cryptos-conf:/home/builder/cryptos/src \
	-v `pwd`/artifacts/repo:/home/builder/packages/ \
	--env srcdir=/home/builder/cryptos/src/src \
	--env builddir=/home/builder/cryptos/src/src/alpine-conf-3.7.0 \
	cryptos-dev-toolchain:dev \
	sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

sign-x8664:
	docker run \
	-v `pwd`/_data/abuild:/home/builder/.abuild \
	-v `pwd`/artifacts/repo/cryptos:/home/builder/packages/ \
	cryptos-dev-toolchain:dev \
	sh -c "cd /home/builder/packages && apk index -o x86_64/APKINDEX.tar.gz x86_64/*.apk && abuild-sign -k /home/builder/.abuild/james.kirby@atlascityfinace.com-5b1125f6.rsa x86_64/APKINDEX.tar.gz"

sign-noarch:
	docker run \
	-v `pwd`/_data/abuild:/home/builder/.abuild \
	-v `pwd`/artifacts/repo/cryptos:/home/builder/packages/ \
	cryptos-dev-toolchain:dev \
	sh -c "cd /home/builder/packages && apk index -o noarch/APKINDEX.tar.gz noarch/*.apk && abuild-sign -k /home/builder/.abuild/james.kirby@atlascityfinace.com-5b1125f6.rsa x86_64/APKINDEX.tar.gz"

clean-docker:
	docker rm -f $(docker ps -a -q)