#!Makefile


TARGET_BIN=rux.bin
TARGET_ISO=rux.iso


CARGO_TARGET=x86_64-rux

KERNEL_IMAGE_DEBUG=target/$(CARGO_TARGET)/debug/rux
KERNEL_IMAGE_RELEASE=target/$(CARGO_TARGET)/release/rux


QEMU_OPTS=-vga std -cdrom $(TARGET_ISO) -m 128M


RUX_MSG="[--Rux->]"


all: debug

.PHONY: debug
debug: kernel_debug verify update

.PHONY: release
release: kernel_release verify update


#
# Build kernel ELF image in debug or release mode.
#
.PHONY: kernel_debug
kernel_debug:
	@echo
	@echo $(RUX_MSG) "Building & linking kernel image (debug mode)..."
	cargo build
	cp $(KERNEL_IMAGE_DEBUG) $(TARGET_BIN)

.PHONY: kernel_release
kernel_release:
	@echo
	@echo $(RUX_MSG) "Building & linking kernel image (release mode)..."
	cargo build --release
	cp $(KERNEL_IMAGE_RELEASE) $(TARGET_BIN)


#
# Verify GRUB multiboot sanity.
#
.PHONY: verify
verify:
	@if grub-file --is-x86-multiboot2 $(TARGET_BIN); then \
		echo;                                             \
		echo $(RUX_MSG) "VERIFY MULTIBOOT2: Confirmed ✓"; \
	else                                                  \
		echo;                                             \
		echo $(RUX_MSG) "VERIFY MULTIBOOT2: FAILED ✗";    \
	fi


#
# Update CDROM image.
#
.PHONY: update
update:
	@echo
	@echo $(RUX_MSG) "Writing to CDROM..."
	mkdir -p isodir/boot/grub
	cp $(TARGET_BIN) isodir/boot/$(TARGET_BIN)
	cp scripts/grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o $(TARGET_ISO) isodir


#
# Launching QEMU.
#
.PHONY: qemu
qemu:
	@echo
	@echo $(RUX_MSG) "Launching QEMU..."
	qemu-system-x86_64 $(QEMU_OPTS)

.PHONY: qemu_vnc
qemu_vnc:
	@echo
	@echo $(RUX_MSG) "Launching QEMU (vnc display)..."
	@echo $(RUX_MSG) "Please connect to 'localhost:5901' in VNC viewer client"
	qemu-system-x86_64 $(QEMU_OPTS) -display vnc=localhost:1


#
# Clean the produced files.
#
.PHONY: clean
clean:
	@echo
	@echo $(RUX_MSG) "Cleaning the build..."
	cargo clean
	rm -f $(TARGET_BIN) $(TARGET_ISO)
