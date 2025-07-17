_: {
  projectRootFile = "flake.nix";
  programs = {
    nixfmt-rfc-style.enable = true;
    yamlfmt.enable = true;
  };
  settings.global.excludes = [
    "*.md"
    "LICENSE"
    ".envrc"
  ];
}
