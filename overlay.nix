{ nixpkgs, bgfx, dylib, JustEnoughMod, ... }:
final: prev: {
  JustEnoughModCore = with final;
    clangStdenv.mkDerivation rec {
      name = "JustEnoughModCore";

      meta.mainProgram = "JustEnoughMod";

      src = ./.;

      enableParallelBuilding = true;

      nativeBuildInputs = [ pkg-config meson ninja ccache makeWrapper ];
      buildInputs = [ SDL2 spdlog libGL ];

      preConfigure = ''
        cp -r ${bgfx} subprojects/bgfx
        cp -r ${dylib} subprojects/dylib
        cp -r ${JustEnoughMod} subprojects/JustEnoughMod

        chmod 777 -R subprojects
      '';

      installPhase = ''
        mkdir -p $out/bin
        mkdir -p $out/bin/Plugins
        cp subprojects/JustEnoughMod/JustEnoughMod $out/bin
        cp subprojects/JustEnoughMod/libJustEnoughMod.so $out/bin
        cp libJustEnoughModCore.so $out/bin/Plugins
        wrapProgram $out/bin/JustEnoughMod \
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libGL ]}
      '';
    };
}
