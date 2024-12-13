# This Makefile is used as a shim to aid people with muscle memory
# so that they can type "make".
#
# This file and all of its targets should not be used by anything important.

all: clean pull configure build install

pull:
	git pull

configure:
	./mach configure --prefix=$CEUADMIN/firefox/nightly

build:
	./mach build

install:
	./mach install

clean:
	./mach clobber

.PHONY: all pull configure build install clean
