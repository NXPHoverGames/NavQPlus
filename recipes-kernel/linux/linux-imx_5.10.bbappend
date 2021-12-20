FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://containers.cfg \
    file://slcan.cfg \
    file://cp21xx.cfg \
    file://0001-imx8mp-evk-navq-dtb-make.patch \
    file://0001-imx8mp-evk-navq-dtb-file.patch \
"

SRCREV = "ef3f2cfc6010c13feb40cfb7fd7490832cf86f45"
 
do_configure_append () {
    ${S}/scripts/kconfig/merge_config.sh -m -O ${WORKDIR}/build ${WORKDIR}/build/.config ${WORKDIR}/*.cfg
}
