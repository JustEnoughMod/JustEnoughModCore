#!/usr/bin/env bash

rm -r ./run/*

mkdir -p ./run/Plugins

cp ./build/subprojects/JustEnoughMod/JustEnoughMod ./run/

cp ./build/subprojects/JustEnoughMod/libJustEnoughMod.so ./run/

cp ./build/libJustEnoughModCore.so ./run/Plugins/

./run/JustEnoughMod
