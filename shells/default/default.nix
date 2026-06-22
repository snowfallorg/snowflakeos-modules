{
  mkShell,
  nixd,
  statix,
  deadnix,
  nixfmt,
}:
mkShell {
  nativeBuildInputs = [
    nixd
    statix
    deadnix
    nixfmt
  ];
}
