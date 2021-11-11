#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SOURCE_DIR="${SCRIPT_DIR}/../externals/mono"
OUT_DIR="${SCRIPT_DIR}/output"

mkdir -p $OUT_DIR

docker build -t mono-linux-arm64 - < ${SCRIPT_DIR}/Dockerfile

cp "${SCRIPT_DIR}/compile.sh" "${SOURCE_DIR}"

docker run --rm  -v "${SOURCE_DIR}:/mono/sources" -v "${OUT_DIR}:/mono/bin" mono-linux-arm64 /mono/sources/compile.sh

rm "${SOURCE_DIR}/compile.sh"
