#!/bin/bash
set -euo pipefail

ISCSI_IP=$1
ISCSI_IP2=$2

yum -y install targetcli lsscsi

udevadm control --reload-rules
udevadm trigger --subsystem-match=block
udevadm settle

required_devices=(mgt mdt1 mdt2 mdt3)
for x in {1..20}; do
    required_devices+=("ost${x}")
done

for device in "${required_devices[@]}"; do
    if [ ! -b "/dev/${device}" ]; then
        echo "Required libvirt disk symlink /dev/${device} was not created" >&2
        udevadm info --export-db | grep -E 'ID_SERIAL(_SHORT)?=' || true
        exit 1
    fi
done

# Rebuild the target configuration deterministically on a newly provisioned
# diskserver root disk. The qcow2 backing disks themselves remain persistent.
targetcli clearconfig confirm=True || true

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

for x in {1..10}; do
    targetcli /backstores/block create "ost${x}" "/dev/ost${x}"
    targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss/tpg1/luns/ create "/backstores/block/ost${x}"
done

for x in {11..20}; do
    targetcli /backstores/block create "ost${x}" "/dev/ost${x}"
    targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss2/tpg1/luns/ create "/backstores/block/ost${x}"
done

for target in testmds testoss testoss2; do
    targetcli "/iscsi/iqn.2015-01.com.whamcloud.lu:${target}/tpg1/portals/" create "${ISCSI_IP}"
    targetcli "/iscsi/iqn.2015-01.com.whamcloud.lu:${target}/tpg1/portals/" create "${ISCSI_IP2}"
done

targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testmds/tpg1/acls create iqn.2015-01.com.whamcloud:testmds1
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testmds/tpg1/acls create iqn.2015-01.com.whamcloud:testmds2
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss/tpg1/acls create iqn.2015-01.com.whamcloud:testoss1
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss/tpg1/acls create iqn.2015-01.com.whamcloud:testoss2
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss2/tpg1/acls create iqn.2015-01.com.whamcloud:testoss3
targetcli /iscsi/iqn.2015-01.com.whamcloud.lu:testoss2/tpg1/acls create iqn.2015-01.com.whamcloud:testoss4

targetcli saveconfig
systemctl enable --now target

if systemctl is-active --quiet firewalld; then
    firewall-cmd --permanent --add-port=3260/tcp
    firewall-cmd --reload
fi

for portal in "${ISCSI_IP}" "${ISCSI_IP2}"; do
    ss -lnt | grep -q "${portal}:3260" || {
        echo "iSCSI target is not listening on ${portal}:3260" >&2
        exit 1
    }
done
