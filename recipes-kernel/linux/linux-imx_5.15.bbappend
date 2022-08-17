FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://cp21xx.cfg \
    file://ov5645tn.cfg \
    file://0001-imx8mp-evk-navq-dtb-make-51532.patch \
    file://imx8mp-evk-navq.dts \
    file://tja1xxc45.cfg \
    file://pcf2131.cfg \
    file://gasket_apex.cfg \ 
    file://joystick.cfg \
    file://imu.cfg \ 
"

# 5.15.5
#SRCREV = "c1084c2773fc1005ed140db625399d5334d94a28"

# 5.15.32
SRCREV = "fa6c3168595c02bd9d5366fcc28c9e7304947a3d"

do_patch:append() {
    cp ${WORKDIR}/imx8mp-evk-navq.dts ${S}/arch/arm64/boot/dts/freescale/
}

do_configure:append () {
    ${S}/scripts/kconfig/merge_config.sh -m -O ${WORKDIR}/build ${WORKDIR}/build/.config ${WORKDIR}/*.cfg
}
