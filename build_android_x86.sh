#!/bin/bash
basepath=$(cd `dirname $0`; pwd)

NDK=D:/NDK/android-ndk-r15c
SYSROOT=$NDK/platforms/android-21/arch-x86/
TOOLCHAIN=$NDK/toolchains/x86-4.9/prebuilt/windows-x86_64/bin/i686-linux-android-
export TMPDIR=$basepath/ffmpegtmp

CPU=x86
PREFIX=$basepath/android/x86/

function build_one
{
./configure \
  --prefix=$PREFIX \
  --enable-shared \
  --disable-static \
  --disable-doc \
  --disable-ffmpeg \
  --disable-ffplay \
  --disable-ffprobe \
  --disable-ffserver \
  --disable-doc \
  --disable-symver \
  --enable-small \
  --disable-yasm \
  --cross-prefix=$TOOLCHAIN \
  --target-os=linux \
  --arch=x86 \
  --enable-cross-compile \
  --sysroot=$SYSROOT \
  --extra-cflags="-Os -fpic" \
$ADDITIONAL_CONFIGURE_FLAG
make clean
make -j4
make install
}

build_one
