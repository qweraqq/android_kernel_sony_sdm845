#!/bin/bash

# https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/master/README.md

# wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/tags/android-14.0.0_r54/clang-r487747c.tar.gz /opt/clang-r487747c
# git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b android-10.0.0_r47 --depth=1 --single-branch --no-tags /opt/aarch64-linux-android-4.9
# git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 -b android-10.0.0_r47 --depth=1 --single-branch --no-tags /opt/arm-linux-androideabi-4.9
CLANG=/opt/clang-r487747c/bin
GCC32=/opt/arm-linux-androideabi-4.9/bin
GCC64=/opt/aarch64-linux-android-4.9/bin
export LD_LIBRARY_PATH=/opt/clang-r445002/lib64:/usr/local/lib:$LD_LIBRARY_PATH
PATH=$CLANG:$GCC64:$GCC32:$PATH
export PATH
export ARCH=arm64
export CLANG_TRIPLE=aarch64-linux-gnu
export CROSS_COMPILE=aarch64-linux-android-
export CROSS_COMPILE_ARM32=arm-linux-androideabi-


output_dir=out
DATE_START=$(date +"%s")
echo "-------------------"
echo "Making Kernel:"
echo "-------------------"
echo

rm -rf out/
make clean & make mrproper
make ARCH=arm64 O="$output_dir" tama_aurora_defconfig
make ARCH=arm64 -j $(nproc) O="$output_dir"

echo
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
echo

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo