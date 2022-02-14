#!/bin/zsh 

# 初始化目录

cleanDir()
{
    if [ -f "u-boot" ];then
        rm -rf ./u-boot/*
    fi

    if [ -f "armv7-lpae-multiplatform" ];then
       rm -rf ./armv7-lpae-multiplatform/*
    fi

    if [ -f "bootloader" ];then
            rm -rf ./bootloader/*
    fi

    if [ -f "kernelfile" ];then
        rm -rf ./kernelfile/*
    fi

    if [ -f "rootfs" ];then
        rm -rf ./rootfs/*
    fi
}

initDir()
{
    if [ ! -d "bootloader" ];then
        mkdir bootloader
    fi

    if [ ! -d "kernelfile" ];then
        mkdir kernelfile
    fi

    if [ ! -d "rootfs" ];then
        mkdir rootfs
    fi
}

# 设置交叉编译器

initCompiler()
{
    sudo apt-get update
    sudo apt install gcc-arm-linux-gnueabihf bison flex swig lzop lzma libmpc-dev u-boot-tools libncurses5-dev:amd64
    export ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
}

# U-Boot

ubootScript()
{
    git clone -b v2022.04-rc1 https://github.com/u-boot/u-boot/ --depth=1
    cd u-boot

    # 编译U-Boot

    make distclean
    make stm32mp15_basic_defconfig
    make DEVICE_TREE=stm32mp157a-dk1 all -j $(nproc)

    # 拷贝启动文件

    cp ./u-boot-spl.stm32 ../bootloader/u-boot-spl.stm32
    cp ./u-boot.img ../bootloader/u-boot.img

    cd ..
    rm -rf u-boot
}

# Linux Kernel

kernelScript()
{
    git clone https://github.com/RobertCNelson/armv7-lpae-multiplatform
    cd armv7-lpae-multiplatform/
    git checkout origin/v5.16.x -b tmp
    sed -i "s/git.kernel.org\/pub\/scm\/linux\/kernel\/git\/stable/mirrors.tuna.tsinghua.edu.cn\/git/g" ./scripts/git.sh
    ./build_kernel.sh
    kernel_version=$(cat "$PWD/KERNEL/include/generated/utsrelease.h" | awk '{print $3}' | sed 's/\"//g' )
    sudo cp ./deploy/${kernel_version}.zImage ../kernelfile/${kernel_version}.zImage
    sudo cp ./deploy/${kernel_version}-dtbs.tar.gz ../kernelfile/${kernel_version}-dtbs.tar.gz
    sudo cp ./deploy/${kernel_version}-modules.tar.gz ../kernelfile/${kernel_version}-modules.tar.gz

    cd ..
    rm -rf armv7-lpae-multiplatform
}

# Ubuntu Rootfs

rootfsScript()
{
    cd rootfs
    wget -c https://rcn-ee.com/rootfs/eewiki/minfs/ubuntu-20.04.3-minimal-armhf-2021-12-20.tar.xz
}

case $1 in
    c|clean)
        cleanDir
        initDir
        ;;
    u|uboot)
        initDir
        initCompiler
        ubootScript
        ;;
    k|kernel)
        initDir
        initCompiler
        kernelScript
        ;;
    r|rootfs)
        initDir
        rootfsScript
        ;;
    *)
        cleanDir
        initDir
        initCompiler
        ubootScript
        kernelScript
        rootfsScript
        ;;
esac
