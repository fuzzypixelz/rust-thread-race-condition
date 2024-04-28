#!/usr/bin/env bash

set -eo pipefail

readonly basename=rust_thread_race_condition

cargo build --release
ls -hal target/release
cp target/release/"$basename".dll.lib .
cp target/release/"$basename".dll .

clang -o test test.c target/release/"$basename".dll.lib

for duration in $(seq 0 20); do
    ./test "$duration" || echo "info: test failed with duration ${duration}"
done
