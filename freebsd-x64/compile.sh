#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
OUT_DIR=$1

pushd $SCRIPT_DIR

CC=clang CXX=clang++ ./autogen.sh

cd "$SCRIPT_DIR/mono/eglib"
make

cd "$SCRIPT_DIR/support"
make

cp .libs/libMonoPosixHelper.so "$OUT_DIR"
strip --strip-all "$OUT_DIR/libMonoPosixHelper.so"
