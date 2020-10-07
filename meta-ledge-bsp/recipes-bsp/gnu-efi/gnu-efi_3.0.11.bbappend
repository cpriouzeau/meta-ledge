DEPENDS_append_armv7a += " gcc-arm-none-eabi-native "

GNU_EFI_CC_ARCH_armv7va = "-march=armv7-a "

EABI_TOOLCHAIN_PREFIX = "${RECIPE_SYSROOT_NATIVE}/${datadir}/gcc-arm-none-eabi/bin/arm-none-eabi-"
EABI_TOOLCHAIN_OPTIONS = " --sysroot=${RECIPE_SYSROOT} "
EXTRA_OEMAKE_EABI = "'ARCH=${@gnu_efi_arch(d)}' 'CC=${EABI_TOOLCHAIN_PREFIX}gcc ${GNU_EFI_CC_ARCH}${EABI_TOOLCHAIN_OPTIONS}' \
                'AS=${EABI_TOOLCHAIN_PREFIX}as ' \
                'LD=${EABI_TOOLCHAIN_PREFIX}ld${EABI_TOOLCHAIN_OPTIONS}' \
                'AR=${EABI_TOOLCHAIN_PREFIX}gcc-ar' \
                'RANLIB=${EABI_TOOLCHAIN_PREFIX}gcc-ranlib' \
                'OBJCOPY=${EABI_TOOLCHAIN_PREFIX}objcopy' \
                'PREFIX=${prefix}' \
                'LIBDIR=${libdir}' \
                "

EXTRA_OEMAKE_ledge-stm32mp157c-dk2 = "${EXTRA_OEMAKE_EABI}"
EXTRA_OEMAKE_ledge-ti-am572x = "${EXTRA_OEMAKE_EABI}"
