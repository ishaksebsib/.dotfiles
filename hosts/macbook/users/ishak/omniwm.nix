# OmniWM tiling window manager; home-manager runs it as a launchd agent.
{
  programs.omniwm = {
    enable = true;
    # OmniWM rejects an incomplete file and falls back to all defaults, so this
    # is its full generated settings.toml, edited to match the Hyprland setup.
    # After an OmniWM upgrade that bumps schemaVersion, regenerate and re-edit it.
    settings = ../../../../bare/omniwm/settings.toml;
  };
}
