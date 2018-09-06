# do a build-repo target for each arch type
.PHONY: build-repo
build-repo: build-csyslinux build-sdk build-baselayout build-base build-cmkinitfs build-conf build-opennode 

.PHONY: sign-x8664
sign-x8664: sign-x8664

.PHONY: sign-noarch
sign-noarch: sign-noarch

.PHONY: sign-all
sign-all: sign-x8664 sign-noarch

build-standard-x8664-iso:
	docker run \
		-v ${KEY_DIR}:/home/builder/.abuild \
		-v ${PWD}/cryports:/home/builder/cryports \
		-v ${PACKAGES_DIR}:/home/builder/repo/cryptos \
		-v ${ISO_DIR}:/home/builder/iso \
		registry.gitlab.engr.atlas:443/cryptos/docker-build:x8664 \
		sh -c " ./cryports/scripts/mkimage.sh \
			--tag edge \
			--outdir /home/builder/iso \
			--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
			--extra-repository http://10.84.172.107 \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
			--arch x86_64 \
			--profile standard"

build-standard-x86-iso:
	docker run \
		-v ${KEY_DIR}:/home/builder/.abuild \
		-v ${PWD}/cryports:/home/builder/cryports \
		-v ${PACKAGES_DIR}:/home/builder/repo/cryptos \
		-v ${ISO_DIR}:/home/builder/iso \
		registry.gitlab.engr.atlas:443/cryptos/docker-build:x8664 \
		sh -c "./cryports/scripts/mkimage.sh \
			--tag edge \
			--outdir /home/builder/iso \
			--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
			--extra-repository http://10.84.172.107 \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \		
			--arch x86 \
			--profile standard"

build-standard-ppc64le-iso:
	docker run \
		-v ${KEY_DIR}:/home/builder/.abuild \
		-v ${PWD}/cryports:/home/builder/cryports \
		-v ${PACKAGES_DIR}:/home/builder/repo/cryptos \
		-v ${ISO_DIR}:/home/builder/iso \
		registry.gitlab.engr.atlas:443/cryptos/docker-build:ppc64le \
		sh -c "./cryports/scripts/mkimage.sh \
			--tag edge \
			--outdir /home/builder/iso \
			--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
			--extra-repository http://10.84.172.107 \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
			--arch ppc64le \
			--profile standard"

build-virtual-x8664-iso:
	docker run \
		-v ${KEY_DIR}:/home/builder/.abuild \
		-v ${PWD}/cryports:/home/builder/cryports \
		-v ${PACKAGES_DIR}:/home/builder/repo/cryptos \
		-v ${ISO_DIR}:/home/builder/iso \
		registry.gitlab.engr.atlas:443/cryptos/docker-build:x8664 \
		sh -c "./cryports/scripts/mkimage.sh \
			--tag edge \
			--outdir /home/builder/iso \
			--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
			--extra-repository http://10.84.172.107 \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
			--arch x86_64 \
			--profile virt"

build-virtual-x86-iso:
	docker run \
		-v ${KEY_DIR}:/home/builder/.abuild \
		-v ${PWD}/cryports:/home/builder/cryports \
		-v ${PACKAGES_DIR}:/home/builder/repo/cryptos \
		-v ${ISO_DIR}:/home/builder/iso \
		registry.gitlab.engr.atlas:443/cryptos/docker-build:x86 \
		sh -c "./cryports/scripts/mkimage.sh \
			--tag edge \
			--outdir /home/builder/iso \
			--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
			--extra-repository http://10.84.172.107 \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
			--arch x86 \
			--profile virt"

build-rpi-aarch64-iso:
	docker run \
		-v ${KEY_DIR}:/home/builder/.abuild \
		-v ${PWD}/cryports:/home/builder/cryports \
		-v ${PACKAGES_DIR}:/home/builder/repo/cryptos \
		-v ${ISO_DIR}:/home/builder/iso \
		registry.gitlab.engr.atlas:443/cryptos/docker-build:aarch64 \
		sh -c "./cryports/scripts/mkimage.sh \
			--tag edge \
			--outdir /home/builder/iso \
			--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
			--extra-repository http://10.84.172.107 \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
			--arch aarch64 \
			--profile rpi"

build-rpi-armhf-iso:
	docker run \
		-v ${KEY_DIR}:/home/builder/.abuild \
		-v ${PWD}/cryports:/home/builder/cryports \
		-v ${PACKAGES_DIR}:/home/builder/repo/cryptos \
		-v ${ISO_DIR}:/home/builder/iso \
		registry.gitlab.engr.atlas:443/cryptos/docker-build:armhf \
		sh -c "./cryports/scripts/mkimage.sh \
			--tag edge \
			--outdir /home/builder/iso \
			--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
			--extra-repository http://10.84.172.107 \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
			--arch armhf \
			--profile rpi"

build-uboot-aarch64-iso:
	docker run \
		-v ${KEY_DIR}:/home/builder/.abuild \
		-v ${PWD}/cryports:/home/builder/cryports \
		-v ${PACKAGES_DIR}:/home/builder/repo/cryptos \
		-v ${ISO_DIR}:/home/builder/iso \
		registry.gitlab.engr.atlas:443/cryptos/docker-build:aarch64 \
		sh -c" ./cryports/scripts/mkimage.sh \
			--tag edge \
			--outdir /home/builder/iso \
			--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
			--extra-repository http://10.84.172.107 \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
			--arch aarch64 \
			--profile uboot"

build-uboot-armhf-iso:
	docker run \
		-v ${KEY_DIR}:/home/builder/.abuild \
		-v ${PWD}/cryports:/home/builder/cryports \
		-v ${PACKAGES_DIR}:/home/builder/repo/cryptos \
		-v ${ISO_DIR}:/home/builder/iso \
		registry.gitlab.engr.atlas:443/cryptos/docker-build:armhf \
		sh -c "./cryports/scripts/mkimage.sh \
			--tag edge \
			--outdir /home/builder/iso \
			--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
			--extra-repository http://10.84.172.107 \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
			--extra-repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
			--arch armhf \
			--profile uboot"

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

sign-armhf:
	docker run \
		-v `pwd`/_data/abuild:/home/builder/.abuild \
		-v `pwd`/artifacts/repo/cryptos:/home/builder/packages/ \
		dbuild:armhf \
		sh -c "cd /home/builder/packages/armhf && apk index -o APKINDEX.tar.gz && abuild-sign -k /home/builder/.abuild/james.kirby@atlascityfinace.com-5b1125f6.rsa APKINDEX.tar.gz"

sign-aarch64:
	docker run \
		-v `pwd`/_data/abuild:/home/builder/.abuild \
		-v `pwd`/artifacts/repo/cryptos:/home/builder/packages/ \
		cryptos-dev-toolchain:dev \
		sh -c "cd /home/builder/packages && apk index -o aarch64/APKINDEX.tar.gz noarch/*.apk && abuild-sign -k /home/builder/.abuild/james.kirby@atlascityfinace.com-5b1125f6.rsa x86_64/APKINDEX.tar.gz"

clean-docker:
	docker rm -f $(docker ps -a -q)
