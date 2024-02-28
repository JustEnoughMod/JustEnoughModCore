{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
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

  outputs = { self, nixpkgs, flake-utils, bgfx, dylib, JustEnoughMod }:
    let
      overlay =
        import ./overlay.nix { inherit nixpkgs bgfx dylib JustEnoughMod; };
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in { packages.default = pkgs.JustEnoughModCore; });
}
