IMAGE_INSTALL:append += " \
                         opencv \     
                         opencv-apps \
                         opencv-samples \
                         python3-opencv \
                         tensorflow-lite-vx-delegate \
                         packagegroup-imx-ml-desktop \
                        "

IMAGE_INSTALL:remove += "chromium-ozone-wayland"

ROOTFS_POSTPROCESS_COMMAND:append += " do_disable_hibernate; do_generate_netplan;"
IMAGE_INSTALL += "install-interface-config install-dns-config"


APTGET_EXTRA_PACKAGES += "\
	netplan.io \
"

APTGET_EXTRA_PACKAGES_remove += "\
	connman \
"

IMAGE_PREPROCESS_COMMAND_remove += "\
	do_fix_connman_conflict \
"
	
do_disable_hibernate() {
	set -x

	ln -s /dev/null ${IMAGE_ROOTFS}/etc/systemd/system/sleep.target
	ln -s /dev/null ${IMAGE_ROOTFS}/etc/systemd/system/suspend.target
	ln -s /dev/null ${IMAGE_ROOTFS}/etc/systemd/system/hibernate.target
	ln -s /dev/null ${IMAGE_ROOTFS}/etc/systemd/system/hybrid-sleep.target
  	sed -i 's/#Allow/Allow/g' ${IMAGE_ROOTFS}/etc/systemd/sleep.conf
  	sed -i 's/=yes/=no/g' ${IMAGE_ROOTFS}/etc/systemd/sleep.conf

	set +x
}

do_generate_netplan() {
	set -x

	echo "network:\n  version: 2\n  renderer: NetworkManager" > ${IMAGE_ROOTFS}/etc/netplan/01-network-manager-all.yaml
	
	set +x
}
