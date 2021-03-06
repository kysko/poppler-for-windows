#!/bin/sh

#VERSION=$1 not used currenty, repository should be already checked out with required version 
PLATFORM="x86"

# if [[ -z $VERSION ]]; then VERSION="1.12.16"; fi

export PKG_CONFIG_PATH=$(pwd)/deps/$PLATFORM/pixman/lib/pkgconfig:$(pwd)/deps/$PLATFORM/freetype/lib/pkgconfig:$(pwd)/deps/$PLATFORM/libpng/lib/pkgconfig
export CFLAGS="-I$(pwd)/deps/$PLATFORM/zlib/include"
export LDFLAGS="-L$(pwd)/deps/$PLATFORM/zlib/lib"
#if [[ -z $CAIRO_TOP ]]; then export CAIRO_TOP="$(pwd)"; fi
CAIRO_TOP="$(pwd)"
if [[ ! -d $CAIRO_TOP/cairo-build ]]; then
    mkdir -p $CAIRO_TOP/cairo-build;
fi;

#cd $TOP/cairo-src
##./autogen.sh
echo "shell=$SHELL" > log.txt
echo "prefix=$CAIRO_TOP/cairo-install" >> log.txt

cd $CAIRO_TOP/cairo-build
../cairo-src/autogen.sh --prefix="$CAIRO_TOP/cairo-install"
patch -N -d ../cairo-src/util/cairo-missing < ../cairo.patch
make install-strip
