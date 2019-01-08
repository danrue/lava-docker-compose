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


clean:
	docker-compose rm -vsf
	docker volume rm lava-server-pgdata
