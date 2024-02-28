#!/usr/bin/env bash

mkdir -p ./run/Plugins

rm ./run/JustEnoughMod
cp ./build/subprojects/JustEnoughMod/JustEnoughMod ./run/JustEnoughMod

rm ./run/libJustEnoughMod.so
cp ./build/subprojects/JustEnoughMod/libJustEnoughMod.so ./run/libJustEnoughMod.so

rm ./run/Plugins/libJustEnoughModCore.so
cp ./build/libJustEnoughModCore.so ./run/Plugins/libJustEnoughModCore.so

./run/JustEnoughMod
