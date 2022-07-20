# 5.15.5_1.0.0

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://cp21xx.cfg \
    file://ov5645tn.cfg \
    file://0001-imx8mp-evk-navq-dtb-make.patch \
    file://imx8mp-evk-navq.dts \
    file://0002-Add-OV5645TN-driver.patch \
    file://0005-TJA11XX-C45-SUPPORT.patch \
    file://0006-TJA11XX-C45-DRIVER.patch \
    file://0007-add-pcf2131-driver.patch \
    file://0008-pcf2131-driver-fix.patch \
    file://tja1xxc45.cfg \
    file://pcf2131.cfg \
    file://gasket_apex.cfg \ 
    file://joystick.cfg \
    file://imu.cfg \ 
"

SRCREV = "c1084c2773fc1005ed140db625399d5334d94a28"

do_patch_append() {
    cp ${WORKDIR}/imx8mp-evk-navq.dts ${S}/arch/arm64/boot/dts/freescale/
}

do_configure_append () {
    ${S}/scripts/kconfig/merge_config.sh -m -O ${WORKDIR}/build ${WORKDIR}/build/.config ${WORKDIR}/*.cfg
}
