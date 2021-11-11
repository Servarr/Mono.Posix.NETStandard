#!/bin/bash

VERSION=$1

FILE="mono-$VERSION.tar.gz"

if [ ! -f "$FILE" ]; then
    wget -q "https://github.com/mono/mono/archive/$FILE"
fi

rm -rf externals
mkdir -p externals/mono
tar xf "$FILE" --strip-components 1 -C externals/mono
