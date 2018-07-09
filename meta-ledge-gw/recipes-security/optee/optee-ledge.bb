SUMMARY = "OPTEE Ledge application"
DESCRIPTION = "OPTEE Ledge (Client and Trusted Applications)"
HOMEPAGE = ""

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=cd95ab417e23b94f381dafc453d70c30"

DEPENDS = "optee-client optee-os python-pycrypto-native"

inherit pythonnative

SRC_URI = "git://git.linaro.org/people/christophe.priouzeau/optee-ledge.git;protocol=https"
SRCREV = "4c565799f8d62f0e25e0be95e51a4294dce2d9c8"

S = "${WORKDIR}/git"

OPTEE_CLIENT_EXPORT = "${STAGING_DIR_HOST}${prefix}"
TEEC_EXPORT = "${STAGING_DIR_HOST}${prefix}"
TA_DEV_KIT_DIR = "${STAGING_INCDIR}/optee/export-user_ta"

EXTRA_OEMAKE = " TA_DEV_KIT_DIR=${TA_DEV_KIT_DIR} \
                 OPTEE_CLIENT_EXPORT=${OPTEE_CLIENT_EXPORT} \
                 TEEC_EXPORT=${TEEC_EXPORT} \
                 HOST_CROSS_COMPILE=${TARGET_PREFIX} \
                 TA_CROSS_COMPILE=${TARGET_PREFIX} \
                 V=1 \
               "

B = "${S}"
do_compile() {
    oe_runmake
}

do_install () {
    mkdir -p ${D}${libdir}/optee_armtz
    mkdir -p ${D}${bindir}
    install -D -p -m0755 ${S}/out/ca/* ${D}${bindir}
    install -D -p -m0444 ${S}/out/ta/* ${D}${libdir}/optee_armtz
}

FILES_${PN} += "${libdir}/optee_armtz/"

# Imports machine specific configs from staging to build
PACKAGE_ARCH = "${MACHINE_ARCH}"
INSANE_SKIP_${PN} += "ldflags"

