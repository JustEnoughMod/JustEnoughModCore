git submodule update --init --recursive
meson subprojects update
meson setup build --cross-file toolchain.ini --reconfigure
meson subprojects download