DESCRIPTION = "Install DNS configuration for NetworkManager"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
	file://resolv.conf \
"

S = "${WORKDIR}"

do_install() {

	install -d ${D}/etc
	install -m 0644 ${S}/resolv.conf ${D}/etc

}

FILES_${PN} = "/etc"
