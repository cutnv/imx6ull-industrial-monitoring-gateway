#!/usr/bin/env bash
set -euo pipefail

UBOOT_SRC="${UBOOT_SRC:-$HOME/work/imx6ull-gateway/u-boot}"
UBOOT_OUT="${UBOOT_OUT:-$HOME/work/imx6ull-gateway/build/u-boot-alpha-v2}"
CROSS_COMPILE="${CROSS_COMPILE:-/usr/bin/arm-linux-gnueabihf-}"
JOBS="${JOBS:-4}"

if [[ ! -f "$UBOOT_SRC/Makefile" ]]; then
    echo "错误：找不到 U-Boot 源码：$UBOOT_SRC" >&2
    exit 1
fi

if [[ ! -f "$UBOOT_SRC/configs/mx6ull_alientek_alpha_defconfig" ]]; then
    echo "错误：源码中没有 ALIENTEK 板级配置" >&2
    exit 1
fi

if ! command -v "${CROSS_COMPILE}gcc" >/dev/null; then
    echo "错误：找不到 ARM 交叉编译器" >&2
    exit 1
fi

mkdir -p "$UBOOT_OUT"

make -C "$UBOOT_SRC" O="$UBOOT_OUT" \
    ARCH=arm \
    CROSS_COMPILE="$CROSS_COMPILE" \
    mx6ull_alientek_alpha_defconfig

make -C "$UBOOT_SRC" O="$UBOOT_OUT" \
    ARCH=arm \
    CROSS_COMPILE="$CROSS_COMPILE" \
    -j"$JOBS"

echo "构建完成："
ls -lh "$UBOOT_OUT/u-boot-dtb.imx"
sha256sum "$UBOOT_OUT/u-boot-dtb.imx"
