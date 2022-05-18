SUMMARY = "SD8987 config"
LICENSE = "BSD"

LIC_FILES_CHKSUM = "file://../nxp_modules.conf;md5=18a2b71289aeb437642ca13581cb38a9"

SRC_URI = " \
	file://nxp_modules.conf \
"

do_install () {
	install -d ${D}/etc/modprobe.d
 
	install -m 755 ${S}/../nxp_modules.conf ${D}/etc/modprobe.d/nxp_modules.conf
}