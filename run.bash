#!/usr/bin/env bash

set -xeo pipefail

readonly basename=rust_thread_race_condition

cargo build --release
ls -hal target/release
cp target/release/"$basename".dll.lib .
cp target/release/"$basename".dll .

clang -o test test.c target/release/"$basename".dll.lib

set +e
for _ in {1..10}; do
  ./test
done
