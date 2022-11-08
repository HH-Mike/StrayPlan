CURRENT_DIR=`pwd`
BUSYBOX_VERSION=busybox-1.24.0
BUSYBOX_DIR=${CURRENT_DIR}/${BUSYBOX_VERSION}

if [ ! -d ${BUSYBOX_DIR} ];then
  tar xvf ${BUSYBOX_DIR}.tar.bz2
fi

if [ ! -f ${BUSYBOX_DIR}/.config ];then
  cp busybox_config ${BUSYBOX_DIR}/.config
  make -C ${BUSYBOX_DIR}
  make -C ${BUSYBOX_DIR} install
fi

if [ ! -f ${CURRENT_DIR}/rootfs.img ];then
  dd if=/dev/zero of=${CURRENT_DIR}/rootfs.img bs=1M count=10
  mkfs.ext4 ${CURRENT_DIR}/rootfs.img
fi

if [ ! -f ${CURRENT_DIR}/fileshare.img ];then
  dd if=/dev/zero of=${CURRENT_DIR}/fileshare.img bs=1M count=100
  mkfs.ext4 ${CURRENT_DIR}/fileshare.img
  sudo mkdir ${CURRENT_DIR}/share
  sudo mount -t ext4 -o loop fileshare.img ${CURRENT_DIR}/share
  sudo umount ${CURRENT_DIR}/share
fi

if [ ! -d ${CURRENT_DIR}/rootfs ];then
  sudo mkdir ${CURRENT_DIR}/rootfs
  sudo mount -t ext4 -o loop ${CURRENT_DIR}/rootfs.img ${CURRENT_DIR}/rootfs
  cd ${CURRENT_DIR}/rootfs
  sudo mkdir dev etc lib usr var proc tmp home root mnt bin sbin opt sys media
  cd ${CURRENT_DIR}/
  sudo cp -ar ${BUSYBOX_DIR}/_install/* ${CURRENT_DIR}/rootfs/
  sudo cp -ar ${BUSYBOX_DIR}/examples/bootfloppy/etc/*  ${CURRENT_DIR}/rootfs/etc
  sudo umount ${CURRENT_DIR}/rootfs
fi

