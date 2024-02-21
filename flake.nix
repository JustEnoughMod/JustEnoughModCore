{
  inputs = { nixpkgs.url = "nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
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
      overlay = final: prev: {
        JustEnoughMod = with final;
          let
            sources = import ./nix/sources.nix;
          in stdenv.mkDerivation rec {
            pname = "JustEnoughModCore";
            inherit version;

            meta.mainProgram = "JustEnoughMod";

            src = ./.;

            enableParallelBuilding = true;

            nativeBuildInputs =
              [ pkg-config meson ninja ccache git binutils makeWrapper ];
            buildInputs = [ SDL2 cmake libGL ];

            preConfigure = ''
              cp -r ${sources.bgfx} subprojects/bgfx
              cp -r ${sources.dylib} subprojects/dylib
              cp -r ${sources.JustEnoughMod} subprojects/JustEnoughMod

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
        (system: { inherit (nixpkgsFor.${system}) JustEnoughMod; });

      defaultPackage =
        forAllSystems (system: self.packages.${system}.JustEnoughMod);

      nixosModules.JustEnoughMod = { pkgs, ... }: {
        nixpkgs.overlays = [ self.overlay ];

        environment.systemPackages = [ pkgs.JustEnoughMod ];
      };
    };
}
