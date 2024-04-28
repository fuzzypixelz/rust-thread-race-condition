#!/usr/bin/env bash

set -xeo pipefail

readonly basename=rust_thread_race_condition

cargo build --release
ls -hal target/release
cp target/release/"$basename".dll.lib .
cp target/release/"$basename".dll .

clang -o test test.c target/release/"$basename".dll.lib

set +e
./test 1000
./test 900
./test 800
./test 700
./test 600
./test 500
./test 400
./test 300
./test 200
./test 100
./test 0
