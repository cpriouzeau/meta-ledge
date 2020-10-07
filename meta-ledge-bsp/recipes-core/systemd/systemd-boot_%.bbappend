FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/:"

COMPATIBLE_HOST = "(x86_64.*|i.86.*|arm.*)-linux"

SRC_URI_append_armv7a = " file://0001-support-command-with-parameter-for-efi_cc.patch "

DEPENDS_append_armv7a += " gcc-arm-none-eabi-native "

EFI_BOOT_IMAGE_arm="bootarm.efi"

EABI_TOOLCHAIN_PREFIX = "${RECIPE_SYSROOT_NATIVE}/${datadir}/gcc-arm-none-eabi/bin/arm-none-eabi-"
EABI_TOOLCHAIN_OPTIONS = " --sysroot=${RECIPE_SYSROOT} "
EABI_CC_ARCH = " ${HOST_CC_ARCH} "
EABI_CC_ARCH_armv7a = "-march=armv7-a"

EABI_CC = "${EABI_TOOLCHAIN_PREFIX}gcc ${EABI_CC_ARCH}${EABI_TOOLCHAIN_OPTIONS}"
EABI_LD = "${EABI_TOOLCHAIN_PREFIX}ld "

EABI_OBJCOPY = "${EABI_TOOLCHAIN_PREFIX}objcopy "

do_write_config_append() {
    cat >${WORKDIR}/meson-${PN}.cross <<EOF
[binaries]
objcopy = ${@meson_array('EABI_OBJCOPY', d)}
EOF
}

EXTRA_OEMESON_remove_ledge-stm32mp157c-dk2 = " -Defi-ld=${@ d.getVar('LD').split()[0]} "
EXTRA_OEMESON_remove_ledge-ti-am572x = " -Defi-ld=${@ d.getVar('LD').split()[0]} "

EXTRA_OEMESON_ADDONS_ARM = " \
    -Defi-ld=${@ d.getVar('EABI_LD').split()[0]} \
    -Defi-cc='${EABI_CC}' \
    "

EXTRA_OEMESON_append_ledge-stm32mp157c-dk2 = "${EXTRA_OEMESON_ADDONS_ARM}"
EXTRA_OEMESON_append_ledge-ti-am572x = "${EXTRA_OEMESON_ADDONS_ARM}"


