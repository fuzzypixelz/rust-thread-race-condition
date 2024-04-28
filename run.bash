#!/usr/bin/env bash

set -xeo pipefail

readonly basename=rust_thread_race_condition
readonly durations=(
    1000
    900
    800
    700
    600
    500
    400
    300
    200
    100
    0
)

cargo build --release
ls -hal target/release
cp target/release/"$basename".dll.lib .
cp target/release/"$basename".dll .

clang -o test test.c target/release/"$basename".dll.lib

for duration in "${durations[@]}"; do
    ./test "$duration" || echo "info: test failed with duration $duration"
done
