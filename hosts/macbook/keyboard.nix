{ config, ... }:
let
  user = config.system.primaryUser;
  asUser = ''launchctl asuser "$(id -u -- ${user})" sudo --user=${user} --'';
in
{
  # Caps/Escape (caps:swapescape on NixOS) are remapped by Kanata now, see
  # kanata.nix. Key mapping stays enabled with no mappings so nix-darwin keeps
  # clearing any hidutil remap, which would otherwise stack on top of Kanata.
  system.keyboard.enableKeyMapping = true;

  # Spotlight on Option+R, like the launcher on mod+R in Hyprland (Option is
  # the mod key). Symbolic hotkey 64 = "Show Spotlight search"; parameters are
  # the character ('r' = 114), key code (R = 15) and modifiers (Option =
  # 524288). Merged with -dict-add: CustomUserPreferences would replace the
  # whole dictionary and drop the other stored shortcuts.
  system.activationScripts.postActivation.text = ''
    ${asUser} defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 \
      '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>114</integer><integer>15</integer><integer>524288</integer></array><key>type</key><string>standard</string></dict></dict>'
    # apply without logging out
    ${asUser} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
