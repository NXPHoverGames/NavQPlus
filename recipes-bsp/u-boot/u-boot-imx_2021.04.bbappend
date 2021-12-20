FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-imx:"

SRC_URI += " \
    file://emcraft-build35.patch \
"

SRCREV = "3463140881c523e248d2fcb6bfc9ed25c0db93bd"
