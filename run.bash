#!/usr/bin/env bash

readonly basename=librust_thread_race_condition

cargo build --release
cp target/release/"$basename".dll.lib .
cp target/release/"$basename".dll .

clang -o test test.c target/release/"$basename".dll.lib
./test
