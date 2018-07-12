# do a build-repo target for each arch type
.PHONY: build-repo
build-repo: build-csyslinux build-sdk build-baselayout build-base build-cmkinitfs build-conf build-opennode 

.PHONY: sign-x8664
sign-x8664: sign-x8664

.PHONY: sign-noarch
sign-noarch: sign-noarch

.PHONY: sign-all
sign-all: sign-x8664 sign-noarch

build-container:
	docker build . --tag cryptos-dev-toolchain:dev

build-opennode:
	docker run \
		-v `pwd`/_data/abuild:/home/builder/.abuild \
		-v `pwd`/cryports/cryptos/opennode:/home/builder/cryptos/src \
		-v `pwd`/artifacts/repo:/home/builder/packages/ \
		cryptos-dev-toolchain:dev \
		sh -c "cd cryptos/src && abuild checksum && abuild -R -c"

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

build-standard-x8664-iso:
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
		--arch x86_64 \
		--profile standard

build-standard-x86-iso:
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
		--arch x86 \
		--profile standard

build-standard-ppc64le-iso:
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
		--arch ppc64le \
		--profile standard		

build-virtual-x8664-iso:
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
		--arch x86_64 \
		--profile virt

build-virtual-x86-iso:
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
		--arch x86 \
		--profile virt				

build-rpi-aarch64-iso:
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
		--arch aarch64 \
		--profile rpi

build-rpi-armhf-iso:
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

build-uboot-aarch64-iso:
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
		--arch aarch64 \
		--profile uboot

build-uboot-armhf-iso:
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
		--profile uboot			

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
