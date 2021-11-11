#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUT_DIR=$1

pushd $SCRIPT_DIR

CC=clang CXX=clang++ MACOSX_DEPLOYMENT_TARGET=10.13 ./autogen.sh

cd "$SCRIPT_DIR/mono/eglib"
make

cd "$SCRIPT_DIR/support"
make

strip -x -c .libs/libMonoPosixHelper.dylib -o "$OUT_DIR/libMonoPosixHelper.dylib"

otool -l ${OUT_DIR}/libMonoPosixHelper.dylib
otool -L ${OUT_DIR}/libMonoPosixHelper.dylib
file ${OUT_DIR}/libMonoPosixHelper.dylib
