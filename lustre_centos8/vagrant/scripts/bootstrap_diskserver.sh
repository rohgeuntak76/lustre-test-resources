#!/bin/bash

ISCI_IP=$1
ISCI_IP2=$2

yum -y install targetcli lsscsi
targetcli /backstores/block create mgt1 /dev/mgt
targetcli /backstores/block create mdt1 /dev/mdt1
targetcli /backstores/block create mdt2 /dev/mdt2
targetcli /backstores/block create mdt3 /dev/mdt3
targetcli /iscsi set global auto_add_default_portal=false
targetcli /iscsi create iqn.2015-01.com.whamcloud.lu:testmds
targetcli /iscsi create iqn.2015-01.com.whamcloud.lu:testoss
targetcli /iscsi create iqn.2015-01.com.whamcloud.lu:testoss2
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testmds/tpg1/luns/ create /backstores/block/mgt1
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testmds/tpg1/luns/ create /backstores/block/mdt1
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testmds/tpg1/luns/ create /backstores/block/mdt2
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testmds/tpg1/luns/ create /backstores/block/mdt3


for x in {1..10}
do
    targetcli /backstores/block create ost${x} /dev/ost${x}
    targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss/tpg1/luns/ create /backstores/block/ost${x}
done

for x in {11..20}
do
    targetcli /backstores/block create ost${x} /dev/ost${x}
    targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss2/tpg1/luns/ create /backstores/block/ost${x}
done

targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testmds/tpg1/portals/ create ${ISCI_IP}
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss/tpg1/portals/ create ${ISCI_IP}
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss2/tpg1/portals/ create ${ISCI_IP}
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testmds/tpg1/portals/ create ${ISCI_IP2}
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss/tpg1/portals/ create ${ISCI_IP2}
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss2/tpg1/portals/ create ${ISCI_IP2}
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testmds/tpg1/acls create iqn.2015-01.com.whamcloud:testmds1
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testmds/tpg1/acls create iqn.2015-01.com.whamcloud:testmds2
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss/tpg1/acls create iqn.2015-01.com.whamcloud:testoss1
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss/tpg1/acls create iqn.2015-01.com.whamcloud:testoss2
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss2/tpg1/acls create iqn.2015-01.com.whamcloud:testoss3
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss2/tpg1/acls create iqn.2015-01.com.whamcloud:testoss4

targetcli saveconfig
systemctl enable target
