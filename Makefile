ARCH=arm
CROSS_COMPILE=arm-linux-gnueabi-
UBOOT_VERSION=u-boot-2017.01
LINUX_VERSION=linux-4.4.153
CURRENT_DIR=$(shell pwd)

all_target=uboot
all_target+=linux

all:${all_target}
	@echo "start"

uboot:
	@if [ ! -d ${CURRENT_DIR}/${UBOOT_VERSION} ];then \
		tar xf ${CURRENT_DIR}/${UBOOT_VERSION}.tar.bz2; \
	fi

	@if [ ! -f ${CURRENT_DIR}/${UBOOT_VERSION}/.config ];then \
		make -C ${CURRENT_DIR}/${UBOOT_VERSION} vexpress_ca9x4_defconfig;\
		make -C ${CURRENT_DIR}/${UBOOT_VERSION} ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-  -j16;\
	fi

linux:
	@if [ ! -d ${CURRENT_DIR}/${LINUX_VERSION} ];then\
		tar xf ${CURRENT_DIR}/${LINUX_VERSION}.tar.xz; \
	fi

	@if [ ! -f ${CURRENT_DIR}/${LINUX_VERSION}/.config ];then \
		make -C ${CURRENT_DIR}/${LINUX_VERSION} ARCH=arm vexpress_defconfig;\
		make -C ${CURRENT_DIR}/${LINUX_VERSION} ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-  -j16;\
	fi







