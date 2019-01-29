up: files
	docker-compose build
	docker-compose up

files:
	# QEMU health-check images
	mkdir -p images/kvm/standard
	wget -nc -P images/kvm/standard/ http://images.validation.linaro.org/kvm/standard/large-stable-6.img.gz

	# Beaglebone Black health-check images
	mkdir -p images/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/dtbs
	wget -nc -P images/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/ http://images.validation.linaro.org/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/vmlinuz
	wget -nc -P images/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/ http://images.validation.linaro.org/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/initramfs.cpio.gz
	wget -nc -P images/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/ http://images.validation.linaro.org/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/modules.tar.gz
	wget -nc -P images/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/ http://images.validation.linaro.org/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/jessie-armhf-nfs.tar.gz
	wget -nc -P images/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/dtbs http://images.validation.linaro.org/snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/dtbs/am335x-boneblack.dtb

	# x15 health-check images
	mkdir -p images/snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-stable-rc-4.19/79/
	wget -nc -P images/snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-stable-rc-4.19/79/ http://snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-stable-rc-4.19/79/zImage--4.19+git0+d0a51a4dd9-r0-am57xx-evm-20190129182816-79.bin
	wget -nc -P images/snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-stable-rc-4.19/79/ http://snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-stable-rc-4.19/79/modules--4.19+git0+d0a51a4dd9-r0-am57xx-evm-20190129182816-79.tgz
	wget -nc -P images/snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-stable-rc-4.19/79/ http://snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-stable-rc-4.19/79/rpb-console-image-lkft-am57xx-evm-20190129182816-79.rootfs.tar.xz
	wget -nc -P images/snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-stable-rc-4.19/79/ http://snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-stable-rc-4.19/79/zImage--4.19+git0+d0a51a4dd9-r0-am57xx-beagle-x15-20190129182816-79.dtb



clean:
	docker-compose rm -vsf
	docker volume rm lava-server-pgdata
