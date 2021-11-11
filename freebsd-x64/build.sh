#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SOURCE_DIR="${SCRIPT_DIR}/../externals/mono"

mkdir -p "${SCRIPT_DIR}/output"

cp "${SCRIPT_DIR}/compile.sh" "${SOURCE_DIR}"

${SOURCE_DIR}/compile.sh "$SCRIPT_DIR/output"

rm "${SOURCE_DIR}/compile.sh"
