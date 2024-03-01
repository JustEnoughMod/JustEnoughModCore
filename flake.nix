{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    flake-utils.url = "github:numtide/flake-utils";
    bgfx = {
      url = "https://github.com/LDprg/bgfx.meson";
      flake = false;
      type = "git";
      submodules = true;
    };
    dylib = {
      url = "https://github.com/LDprg/dylib.meson";
      flake = false;
      type = "git";
      submodules = true;
    };
    JustEnoughMod = {
      url = "https://github.com/LDprg/JustEnoughMod";
      flake = false;
      type = "git";
      submodules = true;
    };
  };

  outputs = { self, nixpkgs, flake-utils, pre-commit-hooks, bgfx, dylib, JustEnoughMod }:
    let
      overlay =
        import ./overlay.nix { inherit nixpkgs bgfx dylib JustEnoughMod; };
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {


              nixpkgs-fmt.enable = true;
            };
          };
        };
        devShells.default = pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
        };
        packages.default = pkgs.JustEnoughModCore;
      });
}
