
all: ModemManager

prepare:
	sudo apt update; apt install -y git make autoconf autoconf-archive libtool build-essential autopoint libglib2.0-dev xsltproc gtk-doc-tools libgudev-1.0-dev libmbim-glib-dev gobject-introspection


libmbim:
	cd libmbim; NOCONFIGURE=1 ./autogen.sh; ./configure --prefix=/usr; make; 
	cd libmbim; sudo make install

libqmi:
	cd libqmi; NOCONFIGURE=1 ./autogen.sh; ./configure --prefix=/usr; make;
	cd libqmi; sudo make install

ModemManager: libmbim libqmi
	cd ModemManager; NOCONFIGURE=1 ./autogen.sh; ./configure --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu; make;

install:
	cd ModemManager; sudo make install

.PHONY: all prepare libmbim libqmi ModemManager install
