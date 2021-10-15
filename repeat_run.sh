#!/bin/bash
workloads=("createfiles.f" "openfiles.f" "filemicro_delete.f" "listdirs.f")
db=$1
workload=$2

if [ $# -ne 2 ]; then
    echo "Wrong arg number"
    exit -1
fi

clean="umount /mnt/tablefs && rm -rf /mnt/pmem/tablefs/* && rm -rf /mnt/pmem/${db}/*"
run_fs="./cmake-build-release-25100-docker/tablefs -mountdir /mnt/tablefs -metadir /mnt/pmem/tablefs -datadir /mnt/pmem/tablefs"


if [ $2 = "all" ]; then
  for wl in ${workloads[@]}
  do
    for i in {1..3} ; do
        echo ${run_fs}
        eval ${run_fs}

        run_bench="filebench -f workloads/${wl} >> run_${db}.log"
        echo ${run_bench}
        eval ${run_bench}

        echo ${clean}
        eval ${clean}
    done
  done
else
  for i in {1..3} ; do
    echo ${run_fs}
    eval ${run_fs}

    run_bench="filebench -f workloads/${workload} >> run_${db}.log"
    echo ${run_bench}
    eval ${run_bench}

    echo ${clean}
    eval ${clean}
  done
fi

