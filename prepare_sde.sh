#!/bin/bash
export SDE=/home/leris/sde/bf-sde-9.13.1
export SDE_INSTALL=$SDE/install
export PATH=${SDE_INSTALL}/bin:${PATH}

LD_LIBRARY_PATH=/usr/local/lib
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/leris/sde/bf-sde-9.13.1/install/lib
export LD_LIBRARY_PATH
sudo $SDE_INSTALL/bin/bf_kdrv_mod_load $SDE_INSTALL 2>&1 /dev/null
sudo sh /sde/s9180-32x-std-platform-bsp-ubuntu-r1.0.5/bsp/utils/i2c_utils_std.sh i2c_init 2>&1 /dev/null

