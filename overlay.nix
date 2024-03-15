{ dylib, JustEnoughMod, ... }:
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
        wayland
        libGL
        vulkan-headers
        vulkan-loader
        vulkan-validation-layers
      ];

      libPath = [ SDL2 spdlog wayland libGL vulkan-loader ];

      preConfigure = ''
        mkdir -p subprojects
        chmod 777 -R subprojects

        cp -r ${JustEnoughMod} subprojects/JustEnoughMod
        chmod 777 -R subprojects

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
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath libPath}
      '';
    };
}
