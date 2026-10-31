{
  # Caps/Escape (caps:swapescape on NixOS) are remapped by Kanata now, see
  # kanata.nix. Key mapping stays enabled with no mappings so nix-darwin keeps
  # clearing any hidutil remap, which would otherwise stack on top of Kanata.
  system.keyboard.enableKeyMapping = true;
}
