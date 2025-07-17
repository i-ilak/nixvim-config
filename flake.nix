{
  description = "i-ilak's nixvim config";

  inputs = {
    # Fix nixpkgs-unstable to commit from 17.07.25, since we need some changes from
    # after 25.05, but dont want to constantly pull unstable
    nixpkgs.url = "github:nixos/nixpkgs/e139aa6a2b5f1f42d682a1fbc60abd355d2b4771";
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
          nixvim' = nixvim.legacyPackages.${system};
          nvim = nixvim'.makeNixvimWithModule {
            inherit pkgs;
            module = ./config;
          };
          treefmt = treefmt-nix.lib.evalModule pkgs ./format.nix;
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
            default = with pkgs; mkShell { inherit (self'.checks.pre-commit-check) shellHook; };
          };
        };
    };
}
