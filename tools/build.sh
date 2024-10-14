#! /bin/bash

root_path=$(pwd)

mkdir -p build && cd build

$root_path/autoconf-2.68/configure --prefix="$root_path/bin"

make && make install

export PATH=$PATH:$root_path/bin/bin

rm -rf *

$root_path/automake-1.11/configure --prefix="$root_path/bin"

make && make install

cd ..

rm -rf build

