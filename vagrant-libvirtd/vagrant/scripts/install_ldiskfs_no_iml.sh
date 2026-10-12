#!/bin/bash

LUSTRE=$1

yum-config-manager --add-repo=https://downloads.whamcloud.com/public/lustre/lustre-2.12.6/el7/server/
yum-config-manager --add-repo=https://downloads.whamcloud.com/public/e2fsprogs/latest/el7/
yum install -y --nogpgcheck lustre kmod-lustre-osd-ldiskfs
