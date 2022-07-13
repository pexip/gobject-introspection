#!/bin/bash

set -e

if [[ "$MSYSTEM" == "MINGW32" ]]; then
    export MSYS2_ARCH="i686"
else
    export MSYS2_ARCH="x86_64"
fi

pacman --noconfirm -Suy

pacman --noconfirm -S --needed \
    git \
    base-devel \
    mingw-w64-$MSYS2_ARCH-toolchain \
    mingw-w64-$MSYS2_ARCH-ccache \
    mingw-w64-$MSYS2_ARCH-meson \
    mingw-w64-$MSYS2_ARCH-python3 \
    mingw-w64-$MSYS2_ARCH-python3-pip \
    mingw-w64-$MSYS2_ARCH-python3-mako \
    mingw-w64-$MSYS2_ARCH-python3-markdown \
    mingw-w64-$MSYS2_ARCH-libffi \
    mingw-w64-$MSYS2_ARCH-pkg-config \
    mingw-w64-$MSYS2_ARCH-cairo \
    mingw-w64-$MSYS2_ARCH-pcre2 \
    mingw-w64-$MSYS2_ARCH-zlib \
    mingw-w64-$MSYS2_ARCH-gettext

export CCACHE_BASEDIR="${CI_PROJECT_DIR}"
export CCACHE_DIR="${CCACHE_BASEDIR}/_ccache"

pip3 install --upgrade --user meson==0.60 flake8 mypy==0.931 types-Markdown
export PATH="$HOME/.local/bin:$PATH"

meson setup \
        -Dwerror=true \
        -Dglib:werror=false \
        -Dcairo=enabled \
        -Ddoctool=enabled \
        --buildtype debug \
        _build

meson compile -C _build

meson test \
        --print-errorlogs \
        --suite=gobject-introspection \
        --no-suite=glib \
        -C _build

python3 -m flake8 --count
python3 -m mypy _build
