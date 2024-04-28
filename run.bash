#!/usr/bin/env bash

set -eo pipefail

readonly basename=rust_thread_race_condition

cargo build --release
ls -hal target/release
cp target/release/"$basename".dll.lib .
cp target/release/"$basename".dll .

clang -o test test.c target/release/"$basename".dll.lib

RUST_BACKTRACE=1 ./test 1000 100 || echo "info: test with 1s sleep in main and 0.1s sleep in thread failed"
./test 100 1000 && echo "info: test with 0.1s sleep in main and 1s sleep in thread succeeded"
