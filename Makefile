BUILD_DIR=build
BOOTLOADER=$(BUILD_DIR)/bootloader/bootloader.o
OS=$(BUILD_DIR)/os/sample.o
DISK_IMG=$(BUILD_DIR)/disk.img

all:bootdisk

init: mkdir -p $(BUILD_DIR)


.PHONY: bootdisk bootloader os

clean:
	make -C bootloader clean
	make -C os clean

bootloader:
	make -C bootloader

os:
	make -C os

qemu:
	pkill -f qemu
	qemu-system-i386 -machine q35 -fda $(DISK_IMG) -gdb tcp::26000 -S -daemonize

bootdisk: bootloader os
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	dd conv=notrunc if=$(BOOTLOADER) of=$(DISK_IMG) seek=0 count=1
	dd conv=notrunc if=$(OS) of=$(DISK_IMG) seek=1 count=1

vnc: qemu
	vncviewer localhost:5900 > /dev/null 2>&1 &

gdb: vnc
	gdb -ex c
