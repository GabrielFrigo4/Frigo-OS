#!/bin/sh

# nasm and qemu
sudo apt install nasm
sudo apt install qemu
sudo apt-get install qemu-kvm

# GCC cross compiler for x86_64 systems (might take quite some time, prepare food)
sudo apt install -y bison
sudo apt install -y flex
sudo apt install -y libgmp3-dev
sudo apt install -y libmpc-dev
sudo apt install -y libmpfr-dev
sudo apt install -y texinfo
sudo apt install -y dosfstools
sudo apt install -y mkisofs

export PREFIX="/usr/local/x86_64elfgcc"
export TARGET=x86_64-elf
export PATH="$PREFIX/bin:$PATH"
export GCC_VERSION=12.2.0
export BINUTILS_VERSION=2.39

mkdir /tmp/src
cd /tmp/src
curl -O http://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.gz
tar xf binutils-$BINUTILS_VERSION.tar.gz
mkdir binutils-build
cd binutils-build
../binutils-$BINUTILS_VERSION/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$PREFIX 2>&1 | tee configure.log
sudo make all install 2>&1 | tee make.log

cd /tmp/src
curl -O https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz
tar xf gcc-$GCC_VERSION.tar.gz
mkdir gcc-build
cd gcc-build
echo Configure: . . . . . . .
../gcc-$GCC_VERSION/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-libssp --enable-language=c,c++ --without-headers
echo MAKE ALL-GCC:
sudo make all-gcc
echo MAKE ALL-TARGET-LIBGCC:
sudo make all-target-libgcc
echo MAKE INSTALL-GCC:
sudo make install-gcc
echo MAKE INSTALL-TARGET-LIBGCC:
sudo make install-target-libgcc
echo HERE U GO MAYBE:
ls $PREFIX/bin
export PATH="$PATH:/usr/local/x86_64elfgcc/bin"
