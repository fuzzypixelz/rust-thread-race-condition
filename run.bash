#!/usr/bin/env bash

set -xeo pipefail

readonly basename=rust_thread_race_condition
readonly durations=(
    100
    90
    80
    70
    60
    50
    40
    30
    20
    10
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
