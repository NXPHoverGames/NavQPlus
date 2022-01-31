FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://cp21xx.cfg \
    file://ov5645tn.cfg \
    file://0001-imx8mp-evk-navq-dtb-make.patch \
    file://imx8mp-evk-navq.dts \
    file://0002-Add-OV5645TN-driver.patch \
    file://0005-TJA11XX-C45-SUPPORT.patch \
    file://0006-TJA11XX-C45-DRIVER.patch \
    file://tja1xxc45.cfg \
"

SRCREV = "a11753a89ec610768301d4070e10b8bd60fde8cd"

do_patch_append() {
    cp ${WORKDIR}/imx8mp-evk-navq.dts ${S}/arch/arm64/boot/dts/freescale/
}

do_configure_append () {
    ${S}/scripts/kconfig/merge_config.sh -m -O ${WORKDIR}/build ${WORKDIR}/build/.config ${WORKDIR}/*.cfg
}
