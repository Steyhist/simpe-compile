#!/bin/bash

# setup color
red='\033[0;31m'
green='\e[0;32m'
white='\033[0m'
yellow='\033[0;33m'

# setup dir
WORK_DIR=$(pwd)
KERN_IMG="${WORK_DIR}/out/arch/arm64/boot/Image-gz.dtb"
KERN_IMG2="${WORK_DIR}/out/arch/arm64/boot/Image.gz"

function clean() {
    echo -e "\n"
    echo -e "$red << cleaning up >> \n$white"
    echo -e "\n"
    rm -rf out
}
#Change X00TD_defconfig to your code name device for example X01BD_defconfig
function build_kernel() {
    export PATH="$HOME/tools/yuki-clang/bin:$PATH"
    make -j$(nproc --all) O=out ARCH=arm64 X00TD_defconfig
    make -j$(nproc --all) O=out \
      ARCH=arm64 \
      LD=ld.lld \
      NM=llvm-nm \
      AR=llvm-ar \
      CC="ccache clang" \
      CLANG_TRIPLE=aarch64-linux-gnu- \
      CROSS_COMPILE=aarch64-linux-gnu- \
      CROSS_COMPILE_ARM32=arm-linux-gnueabi-

    if [ -e "$KERN_IMG" ] || [ -e "$KERN_IMG2" ]; then
        echo -e "\n"
        echo -e "$green << compile kernel success! >> \n$white"
        echo -e "\n"
    else
        echo -e "\n"
        echo -e "$red << compile kernel failed! >> \n$white"
        echo -e "\n"
    fi
}

# execute
clean
build_kernel
