#!/bin/sh


echo "Changing scheduler"
echo noop > /sys/block/sda/queue/scheduler
echo noop > /sys/block/sdb/queue/scheduler
echo "Check me after changes"
echo
cat /sys/block/sda/queue/scheduler
cat /sys/block/sdb/queue/scheduler
echo
echo "Doing sysctl tunes"
echo
sysctl -w kernel.sysrq=1

# kernel.threads-max=4096
# kernel.random.poolsize=4096

sysctl -w kernel.threads-max=2048

# vm.overcommit_memory=0
sysctl -w vm.overcommit_memory=2
# vm.overcommit_ratio=50
sysctl -w vm.overcommit_ratio=100
# vm.page-cluster=3
sysctl -w vm.page-cluster=1
# vm.swappiness=60
sysctl -w vm.swappiness=20
# vm.dirty_writeback_centisecs=500
# vm.dirty_expire_centisecs=3000
sysctl -w vm.dirty_writeback_centisecs=500
sysctl -w vm.dirty_expire_centisecs=1500
# vm.dirty_ratio=20
sysctl -w vm.dirty_ratio=95
# vm.dirty_background_ratio=10
sysctl -w vm.dirty_background_ratio=60
# vm.min_free_kbytes=2039
sysctl -w vm.min_free_kbytes=4096
# vm.vfs_cache_pressure=100
sysctl -w vm.vfs_cache_pressure=1000
# fs.file-max=23823
# fs.nr_open=1048576
sysctl -w fs.file-max=23823
sysctl -w fs.nr_open=104857

# net.core.dev_weight=64
sysctl -w net.core.dev_weight=16

sysctl -w net.ipv4.route.gc_thresh=2048
sysctl -w net.ipv4.route.max_size=4096

# net.ipv4.tcp_timestamps=1
# net.ipv4.tcp_window_scaling=1
# net.ipv4.tcp_sack=1
# net.ipv4.tcp_max_orphans=8192
# net.ipv4.tcp_max_tw_buckets=16384
sysctl -w net.ipv4.tcp_timestamps=0
sysctl -w net.ipv4.tcp_window_scaling=0
sysctl -w net.ipv4.tcp_sack=0
sysctl -w net.ipv4.tcp_max_orphans=1024
sysctl -w net.ipv4.tcp_max_tw_buckets=4096

# net.ipv4.igmp_max_memberships=20
sysctl -w net.ipv4.igmp_max_memberships=5

# net.ipv4.igmp_max_msf=10
sysctl -w net.ipv4.igmp_max_msf=5

# net.ipv4.tcp_fack=1
sysctl -w net.ipv4.tcp_fack=0

# net.ipv4.tcp_dsack=1
sysctl -w net.ipv4.tcp_dsack=0

# net.ipv4.tcp_frto=2
sysctl -w net.ipv4.tcp_frto=0

sysctl -w net.ipv4.tcp_reordering=3
sysctl -w net.ipv4.tcp_ecn=2

sysctl -w net.ipv4.conf.all.accept_redirects=0

sysctl -w net.ipv4.conf.default.accept_redirects=0

sysctl -w net.ipv4.conf.lo.accept_redirects=1

sysctl -w net.ipv4.conf.egiga0.accept_redirects=0

sysctl -w net.ipv4.ipfrag_high_thresh=262144
sysctl -w net.ipv4.ipfrag_low_thresh=131072

sysctl -w net.ipv4.icmp_ratelimit=250




