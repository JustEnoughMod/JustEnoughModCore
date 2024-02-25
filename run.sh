#!/usr/bin/env bash

mkdir -p ./run/Plugins
cp ./build/subprojects/JustEnoughMod/JustEnoughMod ./run/JustEnoughMod
cp ./build/subprojects/JustEnoughMod/libJustEnoughMod.so ./run/libJustEnoughMod.so
cp ./build/libJustEnoughModCore.so ./run/Plugins/libJustEnoughModCore.so
./run/JustEnoughMod