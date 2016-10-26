#!/bin/bash

set -e

DEPS_DIR=$HOME/pepper_deps
UP=`pwd`
mkdir -p $DEPS_DIR/lib/python
ln -sf $DEPS_DIR/lib $DEPS_DIR/lib64

TAR="tar xvzf"

# papi
echo "installing PAPI"
$TAR papi-5.4.1.tar.gz
cd papi-5.4.1/src
./configure --prefix=$DEPS_DIR
make
make install
cd $UP

# chacha
echo "installing chacha"
$TAR chacha-fast.tar.gz
cd chacha-fast
make PREFIX=$DEPS_DIR
make PREFIX=$DEPS_DIR install
cd $UP

# NTL
echo "installing NTL"
$TAR ntl-5.5.2.tar.gz
cd ntl-5.5.2/src
./configure PREFIX=$DEPS_DIR
make
make install
cd $UP 

# libconfig 
echo "installing libconfig"
$TAR libconfig-1.4.8.tar.gz
cd libconfig-1.4.8
./configure --prefix=$DEPS_DIR
make
make install
cd $UP

# Cheetah template library
echo "installing Cheetah template library"
$TAR Cheetah-2.4.4.tar.gz
cd Cheetah-2.4.4
export PYTHONPATH=${DEPS_DIR}/lib/python/:${PYTHONPATH}
python2.7 setup.py install --home $DEPS_DIR
cd $UP

# GMPMEE
echo "installing gmpmee"
$TAR gmpmee-0.1.5.tar.gz
cd gmpmee-0.1.5
./configure --prefix=$DEPS_DIR
make
make install
cd $UP

# fcgi
echo "installing fcgi"
$TAR fcgi-2.4.0.tar.gz
cd fcgi-2.4.0
./configure --prefix=$DEPS_DIR
make
make install
cd $UP

# pbc
echo "installing pbc"
$TAR pbc-0.5.13.tar.gz
cd pbc-0.5.13
./configure LDFLAGS="-lgmp" --prefix=$DEPS_DIR
make
make install
cd $UP

#Kyoto Cabinet
echo "installing Kyoto Cabinet"
$TAR kyotocabinet-1.2.76.tar.gz
cd kyotocabinet-1.2.76
./configure --prefix=$DEPS_DIR
make
make install
cd $UP

#leveldb
echo "installing leveldb"
$TAR leveldb-1.10.0.tar.gz
cd leveldb-1.10.0
make
cp --preserve=links libleveldb.* $DEPS_DIR/lib
cp -r include/leveldb $DEPS_DIR/include
cd $UP

#xbyak
echo "installing xbyak"
git clone https://github.com/herumi/xbyak.git
cd xbyak
make PREFIX=$DEPS_DIR install
cd $UP

#ate-pairing
echo "installing ate-pairing"
git clone https://github.com/herumi/ate-pairing.git
cd ate-pairing
make
mkdir -p $DEPS_DIR/lib/libzm
cp lib/libzm.a $DEPS_DIR/lib/libzm
mkdir -p $DEPS_DIR/include/libzm
cp include/* $DEPS_DIR/include/libzm
cd $UP
