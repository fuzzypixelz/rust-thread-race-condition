#!/usr/bin/env bash

set -xeo pipefail

readonly basename=rust_thread_race_condition

cargo build --release
cp target/release/"$basename".dll.lib .
cp target/release/"$basename".dll .

clang -o test test.c target/release/"$basename".dll.lib
./test
