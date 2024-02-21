git submodule update --init --recursive
meson subprojects update
meson setup build --buildtype=debugoptimized --optimization=g --cross-file toolchain.ini --reconfigure
meson subprojects download