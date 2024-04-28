#!/usr/bin/env bash

set -xeo pipefail

readonly basename=rust_thread_race_condition

cargo build --release
ls -hal target/release
cp target/release/"$basename".dll.lib .
cp target/release/"$basename".dll .

clang -o test test.c target/release/"$basename".dll.lib

set +e
./test 60
./test 50
./test 40
./test 30
./test 20
./test 10
./test 9
./test 8
./test 7
./test 6
./test 5
./test 4
./test 3
./test 2
./test 1
./test 0
