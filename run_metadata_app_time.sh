#!/bin/bash

db=$1
test_dir=$2

clean="umount /mnt/tablefs && rm -rf /mnt/pmem/tablefs/* && rm -rf /mnt/pmem/${db}/*"
run_fs="/home/src/tablefs/cmake-build-release-25100-docker/tablefs -mountdir /mnt/tablefs -metadir /mnt/pmem/tablefs -datadir /mnt/pmem/tablefs"

test_rsync="time rsync -r linux-5.14.11 ${test_dir}/ | grep real"
test_tar="time tar -zcf linux.tar ${test_dir}/* | grep real"
test_untar="time tar -xf linux-5.14.11.tar.xz -C ${test_dir}/ | grep real"
test_diff="time diff -rq /mnt/tablefs/linux-5.14.11 /mnt/tablefs/linux-4.4.288  > /dev/null | grep real"

# rsync
eval ${run_fs}
eval ${test_rsync}
# tar
eval ${test_tar}
eval ${clean}

# untar
eval ${run_fs}
eval ${test_untar}
cp -r linux-4.4.288 /mnt/tablefs/
eval ${test_diff}
eval ${clean}
