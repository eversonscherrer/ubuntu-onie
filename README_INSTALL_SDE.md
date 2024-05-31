# Installing P4STUDIO and BSP on Ubuntu 20.04

This example demonstrates how to install a p4studio (bf-sde) tofino s9180-32x
This README covers:

* Install bf-sde
* Initialize Platform bsp
* Run simple p4 example

## Install bf-sde

After you download p4studio from intel

```
ubuntu:~$ sudo tar -xzvf bf-sde-<>.<>.tgz
ubuntu:~$ cd  bf-sde-<>.<>
ubuntu:~$ sudo export SDE=/root/bf-sde-9.13.1
ubuntu:~$ sudo export SDE_INSTALL=$SDE/install
ubuntu:~$ sudo export PATH=$SDE_INSTALL/bin:$PATH
ubuntu:~$ cd p4studio
ubuntu:~$ sudo ./p4studio/p4studio profile apply profile-tf1.yaml
ubuntu:~$ sudo ./p4studio dependencies install
```

Now the bf-sde is installed you need to install your correct bsp that matches your platform.

## Initialize Platform bsp

After you download corresponding std platform for ubuntu let's install

```
ubuntu:~$ tar -xzvf s9180-32x-std-platform-bsp-ubuntu-<>.<>.tgz
ubuntu:~$ cd s9180-32x-std-platform-bsp-ubuntu-<>.<>
ubuntu:~$ cd bsp
ubuntu:~$ make
ubuntu:~$ make install
ubuntu:~$ cp utils/*.sh /usr/sbin/
ubuntu:~$ i2c_utils_std.sh i2c_init
```

## Run simple p4 example

```
ubuntu:~$ sudo source prepare_sde.sh
ubuntu:~$ sudo $SDE/run_switchd.sh -p switch 
```

You will see this screen

```
BF_SWITCHD DEBUG - bf_switchd: thrift initialized for agent : 0
BF_SWITCHD DEBUG - bf_switchd: spawning cli server thread
BF_SWITCHD DEBUG - bf_switchd: spawning driver shell
BF_SWITCHD DEBUG - bf_switchd: server started - listening on port 9999
bfruntime gRPC server started on 0.0.0.0:50052

        ********************************************
        *      WARNING: Authorised Access Only     *
        ********************************************


bfshell>
```

After that just you cofigure all you need to run your p4 code.