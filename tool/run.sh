#!/bin/bash

set -e

PROJECT_ROOT=..
TOOLS_PATH=$PROJECT_ROOT/tool
SDK_PATH=$PROJECT_ROOT/sdk

ARM_GCC_PATH=$TOOLS_PATH/gcc-arm-none-eabi-5_4-2016q3
NRF5X_COMMAND_LINE_PATH=$TOOLS_PATH/nRF5x-Command-Line-Tools_9_8_1
NRF5_SDK_12_3_0_PATH=$SDK_PATH/nRF5_SDK_12.3.0_d7731ad 
NRF5_SDK_15_2_0_PATH=$SDK_PATH/nRF5_SDK_15.2.0_9412b96

ARM_GCC_LINK=https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
NRF5X_COMMAND_LINE_LINK=https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF5-command-line-tools/sw/nRF-Command-Line-Tools_9_8_1_Linux-x86_64.tar
NRF5_SDK_12_3_0_LINK=http://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v12.x.x/nRF5_SDK_12.3.0_d7731ad.zip
NRF5_SDK_15_2_0_LINK=http://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v15.x.x/nRF5_SDK_15.2.0_9412b96.zip

#--------------------------------------------------------------------------
function install_arm_gcc(){
    echo "> install arm gcc tool ..."
    if [ ! -d $ARM_GCC_PATH ]; then 
        pack=gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 
        wget -O $pack $ARM_GCC_LINK 
		tar -xjvf $pack 
		rm -rf $pack 
	fi
}

function install_nrf5x_command_line(){
    echo "> install nRF5x command line tool ..."
    if [ ! -d $NRF5X_COMMAND_LINE_PATH ]; then 
        pack=nRF5x-Command-Line-Tools_9_7_3_Linux-x86_64.tar
        wget  -O $pack $NRF5X_COMMAND_LINE_LINK
        mkdir $NRF5X_COMMAND_LINE_PATH
        tar -xvf $pack -C $NRF5X_COMMAND_LINE_PATH
        rm -rf $pack 
    fi
}

function install_nrf5_sdk_12_3_0(){
    echo "> install nRF5 SDK 12.3.0 ..."
    if [ ! -d $NRF5_SDK_12_3_0_PATH ]; then 
        if [ ! -d $SDK_PATH ]; then
            mkdir -p $SDK_PATH
        fi

        pack=nRF5_SDK_12.3.0_d7731ad
        wget -O $pack.zip $NRF5_SDK_12_3_0_LINK 
        unzip -X $pack.zip
        rm -rf $pack.zip
        mv $pack $SDK_PATH
    fi

    echo "> update the *.posix file, when the project root is changed ..."
    t_arm_gcc_path=`pwd`/gcc-arm-none-eabi-5_4-2016q3
    posix_file=$NRF5_SDK_12_3_0_PATH"/components/toolchain/gcc/Makefile.posix"
    echo "GNU_INSTALL_ROOT := $t_arm_gcc_path" > $posix_file
    echo "GNU_VERSION := 5.4.1" >> $posix_file
    echo "GNU_PREFIX := arm-none-eabi" >> $posix_file   
}

function install_nrf5_sdk_15_2_0(){
    echo "> install nRF5 SDK 15.2.0 ..."
    if [ ! -d $NRF5_SDK_15_2_0_PATH ]; then 
        if [ ! -d $SDK_PATH ]; then
            mkdir -p $SDK_PATH
        fi

        pack=nRF5_SDK_15.2.0_9412b96
        wget -O $pack.zip $NRF5_SDK_15_2_0_LINK 
        unzip -X $pack.zip
        rm -rf $pack.zip
        mv $pack $SDK_PATH
    fi

    echo "> update the *.posix file, when the project root is changed ..."
    t_arm_gcc_path=`pwd`/gcc-arm-none-eabi-5_4-2016q3
    posix_file=$NRF5_SDK_15_2_0_PATH"/components/toolchain/gcc/Makefile.posix"
    echo "GNU_INSTALL_ROOT := $t_arm_gcc_path/bin/" > $posix_file
    echo "GNU_VERSION := 5.4.1" >> $posix_file
    echo "GNU_PREFIX := arm-none-eabi" >> $posix_file   
}
#--------------------------------------------------------------------------

function tool(){
    install_arm_gcc;
    install_nrf5x_command_line;
    install_nrf5_sdk_12_3_0;
    install_nrf5_sdk_15_2_0;
}

function clean(){
    echo "Cleaning..."
    rm -rf $ARM_GCC_PATH
    rm -rf $NRF5X_COMMAND_LINE_PATH
    rm -rf $NRF5_SDK_12_3_0_PATH
    rm -rf $NRF5_SDK_15_2_0_PATH
}


if [ "$1" == "clean" ]; then
    clean
elif [ "$1" == "tool" ]; then
    tool
else
    echo "error"
fi
