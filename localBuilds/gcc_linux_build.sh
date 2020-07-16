#!/bin/bash

gcc_version=5.2.0
# gcc_version=7.3.0
build_foler=~/TEMP/gcc_${gcc_version}
mkdir -p $build_foler
cd $build_foler

wget http://www.netgull.com/gcc/releases/gcc-${gcc_version}/gcc-${gcc_version}.tar.gz

mkdir -p $HOME/.local/gcc-${gcc_version}

tar xzf gcc-${gcc_version}.tar.gz
cd gcc-${gcc_version}
./contrib/download_prerequisites
mkdir build && cd build
../configure --prefix=$HOME/.local/gcc-${gcc_version} --enable-languages=c,c++,fortran,go
make
make install

cat<<EOF >> ~/.bash_profile
#=============== GCC =================
gcc_version=${gcc_version}
export PATH=~/.local/gcc-\${gcc_version}/bin:\$PATH
export LD_LIBRARY_PATH=~/.local/gcc-\${gcc_version}/lib:\$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=~/.local/gcc-\${gcc_version}/lib64:\$LD_LIBRARY_PATH
export CC=~/.local/gcc-\${gcc_version}/bin/gcc
export CXX=~/.local/gcc-\${gcc_version}/bin/g++
export FC=~/.local/gcc-\${gcc_version}/bin/gfortran
#======================================
EOF

