# Installing Ubuntu 20.04 on a ONIE System

This example demonstrates how to create an ONIE compatible installer
image from a Ubuntu Focal .ISO file.  This README covers:

* Building the  ONIE installer
* Using a Ubuntu preseed.cfg file to automate installation in an ONIE environment

## Building the Ubuntu ONIE installer

Before building the installer make sure you have `wget` and `xorriso`
installed on your system.  On a Ubuntu based system the following is
sufficient:

```
build-host:~$ sudo apt update
build-host:~$ sudo apt install xorriso
```

To build the Ubuntu ONIE installer change directories to `ubuntu-iso`
and type the following:

```
build-host:~$ cd /ubuntu-iso
build-host:~/ubuntu-iso$ ./cook-bits.sh
Downloading Ubuntu Focal mini.iso ...
...
Saving to: `./input/ubuntu-focal-amd64-mini.iso'

100%[==================================================================================================>] 29,360,128  3.11M/s   in 8.6s    

2015-10-09 10:15:12 (3.25 MB/s) - `./input/ubuntu-focal-amd64-mini.iso' saved [29360128/29360128]

Creating ./output/ubuntu-focal-amd64-mini-ONIE.bin: .xorriso 1.2.2 : RockRidge filesystem manipulator, libburnia project.

xorriso : NOTE : Loading ISO image tree from LBA 0
xorriso : UPDATE : 280 nodes read in 1 seconds
xorriso : NOTE : Detected El-Torito boot information which currently is set to be discarded
Drive current: -indev './input/ubuntu-focal-amd64-mini.iso'
Media current: stdio file, overwriteable
Media status : is written , is appendable
Boot record  : El Torito , ISOLINUX boot image capable of isohybrid
Media summary: 1 session, 11098 data blocks, 21.7m data, 1210g free
Volume id    : 'ISOIMAGE'
Copying of file objects from ISO image to disk filesystem is: Enabled
xorriso : UPDATE : 280 files restored ( 21495k) in 1 seconds = 15.9xD
..... Done.
```

The resulting ONIE installer file is available in the `output` directory:

```
build-host:~/ubuntu-iso$ ls -l output/
total 17812
-rw-r--r-- 1 user user 18238940 Oct  9 10:15 ubuntu-focal-amd64-mini-ONIE.bin
```

## Preparing the FTP image server

Put the `ubuntu-focal-amd64-mini-ONIE.bin` file and
`ubuntu-preseed.txt` file into the document root of the FTP server:

```
/ Navigate to the location where the downloaded files are located.
build-host:~/ ftp -p your.ftp.ip.address
/ type user and password to FTP server,

/ Upload ubuntu-preseed.cfg and ubuntu-focal-amd64-mini-ONIE.bin to FTP server.
build-host:~/ put ubuntu-preseed.cfg
build-host:~/ put ubuntu-focal-amd64-mini-ONIE.bin
build-host:~/ exit
```

## Installing the Ubuntu installer from ONIE

Back in ONIE.  First double check that the network is working
correctly:

```
ONIE:/ # ping your.ftp.server.address
```
Now proceed with installing the ONIE compatible Ubuntu installer:

```
ONIE:/ # onie-nos-install onie-nos-install ftp://user:password@your.ftp.ip.address/ubuntu-focal-amd64-mini-ONIE.bin
discover: Rescue mode detected. No discover stopped.
Info: Fetching ftp://*.*.*.*/ubuntu-focal-amd64-mini-ONIE.bin ...
Connecting to ftp://*.*.*.*/
installer            100% |*******************************| 17811k  0:00:00 ETA
ONIE: Executing installer: ftp://*.*.*.*/ubuntu-focal-amd64-mini-ONIE.bin
Verifying image checksum ... OK.
Preparing image archive ... OK.
Loading new kernel ...
kexec: Starting new kernel
...
```

The Ubuntu installer kernel will now kexec and you are off to the
races.  The Ubuntu installer will pull down the preseed.cfg file and
continue the install process.

## Poking around Ubuntu after the install

When complete the Ubuntu system will have the following:

- a sudo-enabled user called `ubuntu` with the login password of `ubuntu`
- GRUB menu entries for ONIE, from /etc/grub.d/40_custom
The GRUB menu looks like:

```
                        GNU GRUB  version 2.04
                                                       
 +----------------------------------------------------------------------------+
 | Ubuntu GNU/Linux                                                           | 
 |*Advanced options for Ubuntu GNU/Linux                                      |
 | ONIE                                                                       |
 |                                                                            |
```
