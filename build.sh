#! /bin/bash

if [[ $# -gt 1 ]]; then
	echo "Usage: $0 [--prefix=/your/path]"
	exit 1
fi
echo $root_path

root_path=$(pwd)

if [[ $# -eq 1 ]]; then
	case $1 in
		--prefix=*)
			root_path="${1#*=}"
			;;
		*)
			echo "Usage: $0 [--prefix=/your/path]"
			exit 1
			;;
	esac
fi

function init() {
	mkdir -p build && cd build
	mkdir -p $root_path
	mkdir -p $root_path/sysroot
	mkdir -p $root_path/sysroot/usr
	mkdir -p $root_path/sysroot/usr/include
	mkdir -p $root_path/sysroot/usr/lib

	export LIBRARY_PATH=/usr/lib/x86_64-linux-gnu
	export PATH=$PATH:$root_path/bin/bin
}

function build_binutils() {
	../binutils/configure \
		--target=riscv64-caffeinix \
		--prefix=$root_path/bin \
		--disable-werror \
		--disable-bootstrap \
		--enable-languages=c \
		--disable-libstdcxx \
		--without-headers \
		--disable-libssp \
		--disable-libquadmath \
		--disable-libgomp \
		--disable-libatomic \
		--disable-libitm \
		--disable-libvtv \
		--disable-libsanitizer

	make -j$(nproc) && make install
}

function build_binutils1() {
	../binutils/configure \
		--target=riscv64-caffeinix \
		--prefix=$root_path/bin \
		--disable-werror \
		-with-sysroot=$root_path/sysroot
	
	make -j$(nproc) && make install
}

function build_gcc1() {
	../gcc/configure \
		--target=riscv64-caffeinix \
		--prefix=$root_path/bin \
		--enable-languages=c \
		-with-sysroot=$root_path/sysroot

	make -j$(nproc) && make install
}

function build_newlib() {
	rm -rf *

	../newlib/configure --prefix=/usr --target=riscv64-caffeinix

	make -j$(nproc) && make DESTDIR=$root_path/sysroot install

	cp -ar $root_path/sysroot/usr/riscv64-caffeinix/* $root_path/sysroot/usr
}

echo $root_path
init
echo $(pwd)
build_binutils
build_gcc
build_newlib
rm -rf $root_path/bin
build_binutils1
build_gcc1
cd ..
rm -rf build
