FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-imx:"

SRC_URI += " \
    file://navq-changes.patch \
"

SRCREV = "1e4568fa41a4b6c607577a432f1a0ab36b6fc3ee"
