include ros2-packages.inc 

IMAGE_PREPROCESS_COMMAND:remove += "do_fix_connman_conflict"

IMAGE_INSTALL:append += "opencv \
			opencv-apps \
			opencv-samples \
			python3-opencv \
			tensorflow-lite-vx-delegate \
			packagegroup-imx-ml-desktop \
			"

IMAGE_INSTALL:remove += "chromium-ozone-wayland"

IMAGE_INSTALL += "install-interface-config install-dns-config"

ROOTFS_POSTPROCESS_COMMAND:remove += " do_update_dns;"
ROOTFS_POSTPROCESS_COMMAND:append += " do_disable_hibernate; do_generate_netplan; \
					do_fix_dns;"

APTGET_EXTRA_PACKAGES += "\
	netplan.io \
"

# Couldn't get v4l2loopback-utils because of dkms failure. Try later maybe?

APTGET_EXTRA_PACKAGES:remove += "\
	connman \
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

fakeroot do_fix_dns() {
	set -x

	rm "${APTGET_CHROOT_DIR}/etc/resolv.conf"
	echo "nameserver 8.8.8.8" > "${APTGET_CHROOT_DIR}/etc/resolv.conf"

	set +x
}
