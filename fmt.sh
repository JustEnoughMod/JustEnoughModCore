#!/usr/bin/env bash

find ./src -name "*.cpp" -o -name "*.hpp" | sed 's| |\\ |g' | xargs clang-format -i

cd subprojects/JustEnoughMod
./fmt.sh
