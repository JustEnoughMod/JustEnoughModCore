{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    bgfx = {
      url = "https://github.com/LDprg/bgfx.meson";
      type = "git";
      submodules = true;
    };
    dylib = {
      url = "https://github.com/LDprg/dylib.meson";
      type = "git";
      submodules = true;
    };
    JustEnoughMod = {
      url = "https://github.com/LDprg/JustEnoughMod";
      type = "git";
      submodules = true;
    };
  };

  outputs = { self, nixpkgs, bgfx, dylib, JustEnoughMod }:
    let
      lastModifiedDate =
        self.lastModifiedDate or self.lastModified or "19700101";
      version = builtins.substring 0 8 lastModifiedDate;

      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        });
    in {
      overlay = final: _: {
        JustEnoughModCore = with final;
          stdenv.mkDerivation rec {
            pname = "JustEnoughModCore";
            inherit version;

            meta.mainProgram = "JustEnoughMod";

            src = ./.;

            enableParallelBuilding = true;

            nativeBuildInputs =
              [ pkg-config meson ninja ccache git binutils makeWrapper ];
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
              mv subprojects/JustEnoughMod/JustEnoughMod $out/bin
              mv subprojects/JustEnoughMod/libJustEnoughMod.so $out/bin
              mv libJustEnoughModCore.so $out/bin/Plugins
              wrapProgram $out/bin/JustEnoughMod \
                --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libGL ]}
            '';
          };
      };

      packages = forAllSystems
        (system: { inherit (nixpkgsFor.${system}) JustEnoughModCore; });

      defaultPackage =
        forAllSystems (system: self.packages.${system}.JustEnoughModCore);

      nixosModules.JustEnoughModCore = { pkgs, ... }: {
        nixpkgs.overlays = [ self.overlay ];

        environment.systemPackages = [ pkgs.JustEnoughModCore ];
      };
    };
}
