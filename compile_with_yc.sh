    PATH="$HOME/workspace/Kernel_tree/yuki-clang/bin:${PATH}" \
      make -j$(nproc --all) \
      ARCH=arm64 \
      LD=ld.lld \
      NM=llvm-nm \
      AR=llvm-ar \
      CC="ccache clang" \
      CLANG_TRIPLE=aarch64-linux-gnu- \
      CROSS_COMPILE=aarch64-linux-gnu- \
      CROSS_COMPILE_ARM32=arm-linux-gnueabi-
