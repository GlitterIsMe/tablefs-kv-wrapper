#!/bin/bash

bench=("createfiles" "openfiles" "filemicro_delete" "listdirs")
db_name=("rocksdb" "utree" "metakv" "hikv" "roart" "tlhash")

#fs_name=$1

#if [ $# -eq 0 ]; then
#  echo "FS name is not found"
#  exit 0
#fi
for db in ${db_name[@]}
do
for bench_file in ${bench[@]}
  do
      if [ ${db} = "rocksdb" ] || [ ${db} = "hikv" ]; then
          mount="taskset -ac 0 ./cmake-build-release-2373-docker/tablefs -mountdir /mnt/tablefs -metadir /mnt/pmem/tablefs -datadir /mnt/pmem/tablefs"
      else
          mount="./cmake-build-release-2373-docker/tablefs -mountdir /mnt/tablefs -metadir /mnt/pmem/tablefs -datadir /mnt/pmem/tablefs"
      fi
      run="filebench -f workloads/${bench_file}.f | tee ${db}-${bench_file}.log"
      clear="umount /mnt/tablefs && rm -rf /mnt/pmem/${db}/* && rm -rf /mnt/pmem/tablefs/*"

      echo ${mount}
      #eval ${mount}

      echo ${run}
      #eval ${run}

      echo ${clear}
      #eval ${clear}

  done
done