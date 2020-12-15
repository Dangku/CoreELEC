# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team CoreELEC (https://coreelec.org)

PKG_NAME="u-boot-Bananapi_M5"
PKG_VERSION="e32178bf68861a172562ae9d330dd7f48d9d738e"
PKG_SHA256="22e421c6506914128dd3ffce6269cc1ae487060ef58b02f472618d20b9692865"
PKG_LICENSE="GPL"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="https://github.com/Dangku/amlogic-u-boot/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain gcc-linaro-aarch64-elf:host gcc-linaro-arm-eabi:host"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  sed -i "s|arm-none-eabi-|arm-eabi-|g" $PKG_BUILD/Makefile $PKG_BUILD/arch/arm/cpu/armv8/*/firmware/scp_task/Makefile 2>/dev/null || true
  sed -i "s|export CROSS_COMPILE=aarch64-none-elf-| |g" $PKG_BUILD/Makefile
}

configure_package() {
  PKG_UBOOT_CONFIG="bananapi_m5_defconfig"
}

make_target() {
  [ "${BUILD_WITH_DEBUG}" = "yes" ] && PKG_DEBUG=1 || PKG_DEBUG=0
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-elf/bin/:$TOOLCHAIN/lib/gcc-linaro-arm-eabi/bin/:$PATH
  DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make mrproper
  DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make $PKG_UBOOT_CONFIG
  DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make HOSTCC="$HOST_CC" HOSTSTRIP="true"
}

makeinstall_target() {
  : # nothing
}
