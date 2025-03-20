_:
{
  projectRootFile = "flake.nix";
  programs = {
    nixpkgs-fmt.enable = true;
  };
  settings.global.excludes = [
    "*.md"
    "LICENSE"
    ".envrc"
    ".github/workflows/*.yml"
  ];
}
