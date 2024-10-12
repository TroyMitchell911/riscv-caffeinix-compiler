###  Getting the sources

This repository uses submodules, but submodules will fetch automatically on demand.

    $ git clone https://github.com/TroyMitchell911/riscv-caffeinix-compiler.git

**Warning: git clone takes around 6.65 GB of disk and download size**

### Prerequisites

Several standard packages are needed to build the toolchain.  

On Ubuntu, executing the following command should suffice:

    $ sudo apt-get install curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev

**[UNTEST] **On Fedora/CentOS/RHEL OS, executing the following command should suffice:

    $ sudo yum install python3 libmpc-devel mpfr-devel gmp-devel gawk  bison flex texinfo patchutils gcc gcc-c++ zlib-devel expat-devel libslirp-devel

**[UNTEST] **On Arch Linux, executing the following command should suffice:

    $ sudo pacman -Syyu curl python3 libmpc mpfr gmp gawk base-devel bison flex texinfo gperf libtool patchutils bc zlib expat libslirp

### Installation

To compile a cross-toolchain, you must first specify an installation address. If you do not specify one, it will be installed in the current source directory.

    $ sudo ./build.sh --prefix=/opt/riscv-caffeinix

Enjoy caffeinix :)