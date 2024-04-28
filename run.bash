#!/usr/bin/env bash

set -eo pipefail

readonly basename=rust_thread_race_condition
readonly durations=$(seq 1 20)

cargo build --release
ls -hal target/release
cp target/release/"$basename".dll.lib .
cp target/release/"$basename".dll .

clang -o test test.c target/release/"$basename".dll.lib

export RUST_BACKTRACE=1
for duration in "${durations[@]}"; do
    ./test "$duration" || echo "info: test failed with duration ${duration}"
done
