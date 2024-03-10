{ bgfx, dylib, JustEnoughMod, ... }:
final: _: {
  JustEnoughModCore = with final;
    clangStdenv.mkDerivation {
      name = "JustEnoughModCore";

      meta.mainProgram = "JustEnoughMod";

      src = ./.;

      enableParallelBuilding = true;

      nativeBuildInputs =
        [ clang-tools pkg-config meson ninja makeWrapper doxygen graphviz ];
      buildInputs = [
        SDL2
        spdlog
        libGL
        vulkan-loader
        wayland
        wayland-protocols
        wayland-scanner
        libxkbcommon
        xorg.libX11
        xorg.libICE
        xorg.libXi
        xorg.libXScrnSaver
        xorg.libXcursor
        xorg.libXinerama
        xorg.libXext
        xorg.libXrandr
        xorg.libXxf86vm
      ];

      preConfigure = ''
        mkdir -p subprojects

        chmod 777 -R subprojects

        cp -r ${JustEnoughMod} subprojects/JustEnoughMod

        chmod 777 -R subprojects

        cp -r ${bgfx} subprojects/JustEnoughMod/subprojects/bgfx
        cp -r ${dylib} subprojects/JustEnoughMod/subprojects/dylib

        chmod 777 -R subprojects
      '';

      installPhase = ''
        mkdir -p $out/bin
        mkdir -p $out/bin/Plugins

        cp subprojects/JustEnoughMod/JustEnoughMod $out/bin
        cp subprojects/JustEnoughMod/libJustEnoughMod.so $out/bin
        cp libJustEnoughModCore.so $out/bin/Plugins

        wrapProgram $out/bin/JustEnoughMod \
          --prefix LD_LIBRARY_PATH : ${
            lib.makeLibraryPath [ libGL vulkan-loader ]
          }
      '';
    };
}
