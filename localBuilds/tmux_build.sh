#!/bin/bash

# INSTALL TMUX FROM SOURCE

TEMP_FOLDER="$HOME/TEMP"
DEPENDENIES_FOLDER="$HOME/TEMP/builds"
LOCAL_BIN="$HOME/.local"

tmux_v="2.6"
libevent_v="2.1.8"
#ncurses_v="5.9"

[ ! -d ${TEMP_FOLDER} ]         && mkdir -p ${TEMP_FOLDER}
[ ! -d ${DEPENDENIES_FOLDER} ]  && mkdir -p ${DEPENDENIES_FOLDER}
[ ! -d ${LOCAL_BIN} ]           && mkdir -p ${LOCAL_BIN}

cd ${TEMP_FOLDER}

wget https://github.com/tmux/tmux/releases/download/{$tmux_v}/tmux-{$tmux_v}.tar.gz
wget https://github.com/libevent/libevent/releases/download/release-${libevent_v}-stable/libevent-${libevent_v}-stable.tar.gz
#wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-${ncurses_v}.tar.gz

tar xvzf libevent-${libevent_v}-stable.tar.gz
cd libevent-${libevent_v}-stable
./configure --prefix=$DEPENDENIES_FOLDER --disable-shared
make
make install
cd ..

#tar xvzf ncurses-${ncurses_v}.tar.gz
#cd ncurses-${ncurses_v}
#./configure --prefix=$DEPENDENIES_FOLDER
#make
#make install
#cd ..

cd tmux-${tmux_v}
#./configure --prefix=$LOCAL_BIN CFLAGS="-I${DEPENDENIES_FOLDER}/include -I${DEPENDENIES_FOLDER}/include/ncurses" LDFLAGS="-L${DEPENDENIES_FOLDER}/lib -L${DEPENDENIES_FOLDER}/include/ncurses -L${DEPENDENIES_FOLDER}/include" CPPFLAGS="-I${DEPENDENIES_FOLDER}/include -I${DEPENDENIES_FOLDER}/include/ncurses" LDFLAGS="-static -L${DEPENDENIES_FOLDER}/include -L${DEPENDENIES_FOLDER}/include/ncurses -L${DEPENDENIES_FOLDER}/lib"
./configure --prefix=$LOCAL_BIN CFLAGS="-I${DEPENDENIES_FOLDER}/include" LDFLAGS="-L${DEPENDENIES_FOLDER}/lib" 
make
make install
#cp tmux $LOCAL_BIN/bin
