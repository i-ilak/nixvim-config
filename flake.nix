{
  description = "i-ilak's nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixvim,
      flake-parts,
      treefmt-nix,
      pre-commit-hooks,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem =
        {
          system,
          pkgs,
          self',
          lib,
          ...
        }:
        let
          unbreakWaylandOverlay = final: prev: {
            wayland = prev.wayland.overrideAttrs (oldAttrs: {
              broken = false;
            });
          };

          modifiedPkgs = pkgs.extend unbreakWaylandOverlay;

          nixvim' = nixvim.legacyPackages.${system};
          nvim = nixvim'.makeNixvimWithModule {
            pkgs = modifiedPkgs;
            module = ./config;
          };
          treefmt = treefmt-nix.lib.evalModule modifiedPkgs ./format.nix;
        in
        {
          checks = {
            pre-commit-check = pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                statix.enable = true;
                nixfmt-rfc-style.enable = true;
                deadnix.enable = true;
              };
            };
          };

          formatter = treefmt.config.build.wrapper;

          packages.default = nvim;

          devShells = {
            default = with modifiedPkgs; mkShell { inherit (self'.checks.pre-commit-check) shellHook; };
          };
        };
    };
}
