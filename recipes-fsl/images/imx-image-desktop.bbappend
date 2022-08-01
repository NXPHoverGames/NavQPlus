IMAGE_PREPROCESS_COMMAND_remove += "\
		do_fix_connman_conflict \
"

IMAGE_INSTALL_append += "opencv \
						opencv-apps \
						opencv-samples \
						python3-opencv \
						tensorflow-lite-vx-delegate \
						packagegroup-imx-ml-desktop \
						"

IMAGE_INSTALL_remove += "chromium-ozone-wayland"

IMAGE_INSTALL += "install-interface-config install-dns-config"

ROOTFS_POSTPROCESS_COMMAND_remove += " do_update_dns;"
ROOTFS_POSTPROCESS_COMMAND_append += " do_disable_hibernate; do_generate_netplan; do_fix_dns; do_install_pip_packages;"

APTGET_EXTRA_PACKAGES += "\
	netplan.io \
	curl \
	gnupg \
	gnupg2 \
	lsb-release \
	input-utils \
	libspnav-dev \
	libbluetooth-dev \
	libcwiid-dev \
	jstest-gtk \
	bash-completion \
	build-essential \
	cmake \
	git \
	ccache \
	pkg-config \
	python3-colcon-common-extensions \
	python3-flake8 \
	python3-pip \
	python3-dev \
	python3-pytest-cov \
	python3-rosdep \
	python3-setuptools \
	python3-testresources \
	python3-vcstool \
	python3-argcomplete \
	python3-empy \
	python3-jinja2 \
	python3-cerberus \
	python3-coverage \
	python3-matplotlib \
	python3-numpy \
	python3-packaging \
	python3-pkgconfig \
	python3-opencv \
	python3-wheel \
	python3-requests \
	python3-serial \
	python3-six \
	python3-toml \
	python3-psutil \
	python3-pysolar \
	g++ \
	gcc \
	gdb \
	ninja-build \
	make \
	bzip2 \
	zip \
	rsync \
	shellcheck \
	tzdata \
	unzip \
	valgrind \
	xsltproc \
	binutils \
	bc \
	libyaml-cpp-dev \
	autoconf \
	automake \
	bison \
	ca-certificates \
	openssh-client \
	cppcheck \
	dirmngr \
	doxygen \
	file \
	gosu \
	lcov \
	libfreetype6-dev \
	libgtest-dev \
	libpng-dev \
	libssl-dev \
	libopencv-dev \
	flex \
	genromfs \
	gperf \
	libncurses-dev \
	libtool \
	uncrustify \
	vim-common \
	libxml2-utils \
	mesa-utils \
	libeigen3-dev \
	protobuf-compiler \
	libimage-exiftool-perl \
	v4l-utils \
	v4l2loopback-utils \
	gstreamer1.0-nice \
	gstreamer1.0-opencv \
"

APTGET_EXTRA_PACKAGES_remove += "\
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

fakeroot do_install_pip_packages() {
	set -x

	python3 -m pip install \
    flake8-blind-except \
    flake8-builtins \
    flake8-class-newline \
    flake8-comprehensions \
    flake8-deprecated \
    flake8-docstrings \
    flake8-import-order \
    flake8-quotes \
    pytest-repeat \
    pytest-rerunfailures \
    pytest

	set +x
}
