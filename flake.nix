{
  description = "i-ilak's nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
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
                nixfmt.enable = true;
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
