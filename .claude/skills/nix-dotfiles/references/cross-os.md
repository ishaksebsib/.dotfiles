# Cross-OS reference

Read when adding a host or user, or writing a module meant for both NixOS and nix-darwin.

## New hosts

**NixOS** — `hosts/<h>/configuration.nix` importing topic files and a generated `hardware.nix` (it sets `nixpkgs.hostPlatform`).
- `networking.hostName = hostName;`
- Declare `users.users.<u>` (`isNormalUser = true`, groups) — blueprint does not create OS users.
- `system.stateVersion` is a string, set once.

**macOS** — `hosts/<h>/darwin-configuration.nix`:

```nix
{ flake, hostName, ... }:
{
  imports = [ flake.darwinModules.homebrew ];   # + flake.modules.common.* when they exist
  nixpkgs.hostPlatform = "aarch64-darwin";      # blueprint derives perSystem from this
  networking.hostName = hostName;
  system.primaryUser = "pro";                   # required by homebrew and system.defaults
  users.users.pro.home = "/Users/pro";          # required: home-manager reads homeDirectory from it
  system.stateVersion = 6;                      # integer on nix-darwin
}
```

Apply with `sudo darwin-rebuild switch --flake .#<h>`. A fish login shell also needs `users.users.<u>.shell` plus `users.knownUsers`/`uid` (verify against nix-darwin docs).

**Non-NixOS Linux** — a host folder with no OS file, only `hosts/<h>/users/<u>/home-configuration.nix` importing `flake.homeModules.shared`; add `targets.genericLinux.enable = true;`. Apply with `home-manager switch --flake .#<u>@<h>`.

**User files** — `hosts/<h>/users/<u>/home-configuration.nix` (a user folder without this file is silently ignored). `<u>` must equal the OS username. Each needs `home.stateVersion` and `programs.home-manager.enable = true;`, and imports `flake.homeModules.shared` plus that OS's user modules.

## home-manager option availability

- **Linux only (platform assertion)**: `xdg.mimeApps`, `xdg.desktopEntries`, `xdg.portal`, `services.network-manager-applet`, `targets.genericLinux`, most `services.*`.
- **Silently ignored on darwin**: `systemd.user.*` (`systemd.enable` defaults to Linux). `dconf` is disabled on darwin; `gtk` is pointless there — keep both in the Linux layer.
- **darwin only**: `targets.darwin.*`, `launchd.agents`.
- **Both, handled internally**: `services.gpg-agent`, `programs.ghostty` (darwin needs `package = pkgs.ghostty-bin`), `xdg.configFile` (writes `~/.config` on both).
- `osConfig` is `null` in standalone mode; `osClass` exists only when integrated.

## NixOS vs nix-darwin system options (for `modules/common/`)

| Area | NixOS | nix-darwin |
|---|---|---|
| `nix.settings`, `fonts.packages`, `environment.systemPackages`, `environment.variables`, `time.timeZone`, `programs.fish.enable` | yes | yes |
| `nix.gc` / `nix.optimise` schedule | `dates` | `interval` (launchd calendar), `dates` errors |
| `environment.sessionVariables`, `i18n.*` | yes | no |
| `users.users.<u>` | `isNormalUser`, `extraGroups` | `home`, `shell`, `uid` only |
| `services.tailscale` | full | `enable`/`package`/`overrideLocalDns` only |
| `system.stateVersion` | string | integer |
| `boot.*`, `hardware.*`, `systemd.*`, pipewire, xserver, hyprland | yes | no |
| Touch ID sudo | — | `security.pam.services.sudo_local.touchIdAuth` |

Put only both-sided options in `modules/common/`. For a schedule or other one-sided option, either keep it in the host layer or merge it with `lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin { ... }` — `mkIf` cannot hide an option the other OS does not declare.
