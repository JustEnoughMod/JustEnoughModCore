mv ./build/subprojects/JustEnoughMod/JustEnoughMod ./build/JustEnoughMod
mv ./build/subprojects/JustEnoughMod/libJustEnoughMod.so ./build/libJustEnoughMod.so
mkdir -p ./build/Plugins
mv ./build/libJustEnoughModCore.so ./build/Plugins/libJustEnoughModCore.so
./build/JustEnoughMod