cmake_minimum_required(VERSION 3.13)
project(leveldb)

add_library(leveldb "")

target_include_directories(leveldb PUBLIC include port .)
if (WIN32)
    target_include_directories(leveldb PUBLIC port/win)
elseif(MACOS)
    add_definitions(-DOS_MACOSX)
else()
    add_definitions(-DOS_LINUX)
endif ()

add_definitions(-DLEVELDB_PLATFORM_POSIX)

target_sources(leveldb PUBLIC
        "db/builder.cc"
        "db/builder.h"
        "db/c.cc"
        "db/db_impl.cc"
        "db/db_impl.h"
        "db/db_iter.cc"
        "db/db_iter.h"
        "db/dbformat.h"
        "db/dbformat.cc"
        "db/filename.cc"
        "db/filename.h"
        "db/log_format.h"
        "db/log_reader.cc"
        "db/log_reader.h"
        "db/log_writer.cc"
        "db/log_writer.h"
        "db/memtable.cc"
        "db/memtable.h"
        "db/repair.cc"
        "db/skiplist.h"
        "db/snapshot.h"
        "db/table_cache.cc"
        "db/table_cache.h"
        "db/version_edit.cc"
        "db/version_edit.h"
        "db/version_set.cc"
        "db/version_set.h"
        "db/write_batch.cc"
        "db/write_batch_internal.h"

        "helpers/memenv/memenv.cc"
        "helpers/memenv/memenv.h"

        "table/block.cc"
        "table/block.h"
        "table/block_builder.cc"
        "table/block_builder.h"
        "table/filter_block.cc"
        "table/filter_block.h"
        "table/format.cc"
        "table/format.h"
        "table/iterator.cc"
        "table/iterator_wrapper.h"
        "table/merger.cc"
        "table/merger.h"
        "table/table.cc"
        "table/table_builder.cc"
        "table/two_level_iterator.cc"
        "table/two_level_iterator.h"

        "port/atomic_pointer.h"
        "port/port.h"
        "port/port_posix.cc"
        "port/port_posix.h"

        "util/arena.cc"
        "util/arena.h"
        "util/bloom.cc"
        "util/cache.cc"
        "util/coding.cc"
        "util/coding.h"
        "util/comparator.cc"
        "util/crc32c.cc"
        "util/crc32c.h"
        "util/env.cc"
        "util/env_posix.cc"
        "util/filter_policy.cc"
        "util/hash.cc"
        "util/hash.h"
        "util/histogram.cc"
        "util/histogram.h"
        "util/logging.cc"
        "util/logging.h"
        "util/mutexlock.h"
        "util/options.cc"
        "util/posix_logger.h"
        "util/random.h"
        "util/status.cc"
        )

target_link_libraries(leveldb pthread)