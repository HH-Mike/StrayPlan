qemu-system-x86_64 -kernel linux-4.4.153/arch/x86_64/boot/bzImage -hda ./rootfs.img -hdb ./fileshare.img -append "root=/dev/sda console=ttyS0" -nographic
