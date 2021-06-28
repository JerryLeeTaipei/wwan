
MODEMMANAGER_VERSION=1.16.6
LIBMBIM_VERSION=1.24.6
LIBQMI_VERSION=1.28.6



all: prepare libqmi libmbim ModemManager

prepare:
	sudo apt update; apt install -y git make autoconf autoconf-archive libtool build-essential autopoint libglib2.0-dev xsltproc gtk-doc-tools libgudev-1.0-dev libmbim-glib-dev gobject-introspection
	sudo systemctl stop ModemManager.service
	sudo systemctl disable ModemManager.service
	sudo apt purge libmbim-glib-dev llibmbim-glib-doc libmbim-glib4 libmbim-glib4-dbg libmbim-proxy libmbim-utils
	sudo apt purge libqmi-glib-dev libqmi-glib-doc libqmi-glib1 libqmi-glib1-dbg libqmi-proxy libqmi-utils

source:
	git clone https://gitlab.freedesktop.org/mobile-broadband/libqmi.git
	git clone https://gitlab.freedesktop.org/mobile-broadband/libmbim.git
	git clone https://gitlab.freedesktop.org/mobile-broadband/ModemManager.git

libmbim:
	cd libmbim; git checkout ${LIBMBIM_VERSION}
	cd libmbim; NOCONFIGURE=1 ./autogen.sh; ./configure --prefix=/usr; make; 
	cd libmbim; sudo make install

libqmi:
	cd libqmi; git checkout ${LIBQMI_VERSION}
	cd libqmi; NOCONFIGURE=1 ./autogen.sh; ./configure --prefix=/usr; make;
	cd libqmi; sudo make install

ModemManager:
	cd ModemManager; git checkout ${MODEMMANAGER_VERSION}
	cd ModemManager; NOCONFIGURE=1 ./autogen.sh; ./configure --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu; make;
	cd ModemManager; sudo make install

clean:
	cd ModemManager; sudo make uninstall
	cd libqmi; sudo make uninstall
	cd libmbim; sudo make uninstall

.PHONY: all prepare source libmbim libqmi ModemManager clean
