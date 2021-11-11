#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUT_DIR=$1

pushd $SCRIPT_DIR

CC=clang CXX=clang++ CFLAGS="-arch arm64 -mmacosx-version-min=10.13" ./autogen.sh \
  --build=x86_64-apple-darwin20.6.0 \
  --host=aarch64-apple-darwin20.6.0


cd "$SCRIPT_DIR/mono/eglib"
make

cd "$SCRIPT_DIR/support"
make

cp .libs/libMonoPosixHelper.dylib "$OUT_DIR/libMonoPosixHelper.dylib"

otool -l ${OUT_DIR}/libMonoPosixHelper.dylib
otool -L ${OUT_DIR}/libMonoPosixHelper.dylib
file ${OUT_DIR}/libMonoPosixHelper.dylib
