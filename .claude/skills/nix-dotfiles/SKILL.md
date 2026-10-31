---
name: nix-dotfiles
description: Structure, placement rules and verification for this Nix dotfiles repo built on numtide/blueprint (NixOS host `nixos`, nix-darwin host `macbook`, standalone home-manager later). Use whenever adding, moving or changing anything in the repo — packages, apps, CLI tools, program configs, services, hosts, users, modules, flake inputs, custom packages in packages/ — or when deciding what is shared across operating systems versus Linux- or macOS-only, or when the user mentions blueprint, flake.nix, home-manager, nix-darwin, hosts/, modules/ or rebuilding.
---

# Nix dotfiles (blueprint)

Blueprint turns folders into flake outputs; there is no hand-written output wiring. Keep the repo predictable by putting every change in the one layer it belongs to, so a new OS host can reuse everything shared without edits.

## Mental model

Blueprint only scans top-level conventions:

| Path | Becomes |
|---|---|
| `hosts/<h>/configuration.nix` | `nixosConfigurations.<h>` |
| `hosts/<h>/darwin-configuration.nix` | `darwinConfigurations.<h>` (input must be named `nix-darwin`) |
| `hosts/<h>/users/<u>/home-configuration.nix` | home-manager user `<u>` inside that host, plus standalone `<u>@<h>` |
| `hosts/<h>/` with only `users/` | standalone home-manager only (non-NixOS Linux) |
| `modules/<type>/<name>` | `flake.modules.<type>.<name>`; `home`/`nixos`/`darwin` also as `flake.homeModules`/`nixosModules`/`darwinModules` |
| `packages/<p>/default.nix` | `packages.<sys>.<p>` filtered by `meta.platforms`, plus `checks.<sys>.pkgs-<p>` |

Everything below those entry points is wired by hand: a new file does nothing until it is added to the `imports` list of `configuration.nix`, `home-configuration.nix` or `modules/home/shared/default.nix`.

Three layers — move something up only when a second consumer needs it:

1. **Portable user config** — `modules/home/shared/` (`flake.homeModules.shared`). Must evaluate on x86_64-linux, aarch64-linux and aarch64-darwin, integrated and standalone.
2. **OS-specific user config** — `hosts/<h>/users/<u>/*.nix`: `hosts/nixos/users/pro/` (Linux desktop — Hyprland, waybar, gtk, mimeApps, clipboard, Linux GUI apps) and `hosts/macbook/users/ishak/` (macOS). The username differs per machine: `pro` on NixOS, `ishak` on the Mac.
3. **System config** — `hosts/<h>/*.nix` topic files (boot, networking, nix, services…). Settings shared by several hosts go to `modules/common/` (NixOS + darwin; today `nix`, `fonts`, `home-manager`, imported as `flake.modules.common.<name>`), `modules/nixos/` or `modules/darwin/`.

Host folder name = `hostName` = flake attribute = machine hostname. Renaming the folder renames the machine.

## Where does it go?

- **CLI tool in nixpkgs that runs on macOS** → `home.packages` in `modules/home/shared/cli.nix`, or its own `shared/<tool>.nix` if it has config.
- **Linux-only tool** → `hosts/nixos/users/pro/<topic>.nix`; if it is a small part of a portable module, guard it in place (`lib.optionals pkgs.stdenv.hostPlatform.isLinux`).
- **Package from a flake input** → `perSystem.<input>.<pkg>` (see `llms.nix`).
- **Program with config** → a `programs.<x>` file in `shared/` if the program runs on both OSes, otherwise in the OS user folder. Prefer `programs.*` options over raw `xdg.configFile`.
- **Config file kept in the program's own format** (not Nix: TOML, conf, JSON…) → `bare/<program>/`, referenced from the Nix module by relative path (`../../../../bare/hypr`, `../../../../bare/omniwm/settings.toml`). Never next to the `.nix` files in `hosts/` or `modules/`.
- **Linux GUI app** → `hosts/nixos/users/pro/apps.nix`; into `shared/apps.nix` only if the nixpkgs package also supports darwin and the user wants it on the Mac.
- **macOS GUI app** → the macOS setup is pure Nix: no Homebrew, no `homebrew.*` options. Use the nixpkgs package (in `shared/apps.nix` if it is wanted on both OSes, else `hosts/macbook/users/ishak/`). If nixpkgs has no darwin build, ask the user before packaging one in `packages/`. Never use nix-ld.
- **Software not packaged anywhere** → `packages/<name>/default.nix`, consumed as `perSystem.self.<name>` from a one-purpose module. See [references/packages.md](references/packages.md).
- **System service** → the matching topic file in `hosts/nixos/` (or a new topic file); shared across NixOS hosts → `modules/nixos/`. User daemons: `systemd.user.*` on Linux, `launchd.agents` on macOS.
- **Setting that differs per OS** → branch in place when it is a small part of a portable module; move the whole module to the OS layer when most of it is OS-specific. Branch on `pkgs.stdenv.hostPlatform.isDarwin`/`isLinux`, never on `hostName`.
- **New host or user, or anything for `modules/common`** → read [references/cross-os.md](references/cross-os.md) first.

Branching idioms used in the repo:

```nix
package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin pkgs.ghostty-bin;        # option value
home.packages = [ ... ] ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.libnotify ];
functions = { ... } // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux { h = ...; };
```

Use `lib.optionalAttrs` (not `mkIf`) when the *option itself* only exists on one OS — `mkIf` still errors on an undeclared option.

## Rules

1. **No `nixpkgs.config` or `nixpkgs.overlays` in host or home modules.** `allowUnfree` is set once on the blueprint call in `flake.nix`, which injects `nixpkgs.pkgs` into hosts; NixOS/nix-darwin assert against config on an external pkgs instance. Overlays, if ever needed, go in the blueprint `nixpkgs.overlays` argument so `packages/` sees them too.
2. **Reference flake packages via `perSystem`**: `perSystem.self.<p>`, `perSystem.<input>.<p>` — not `inputs.<x>.packages.${system}`. Use `pkgs.<p>` for nixpkgs (`perSystem.nixpkgs` lacks allowUnfree).
3. **Use `flake`, not `self`** (`self` throws in blueprint).
4. **`hostName` exists only in system modules.** Home modules use `osConfig.networking.hostName`, guarded with `osConfig != null` because standalone home-manager has `osConfig = null`.
5. **Nothing Linux-only in `modules/home/shared/` unguarded**: `systemd.user.*`, `xdg.mimeApps`, `xdg.desktopEntries`, `gtk`, `dconf`, `wayland.*`, `services.*` desktop daemons, Linux-only packages. Most fail a home-manager platform assertion on darwin.
6. **Package files take `{ pkgs, ... }:`** — blueprint's scope is not callPackage, so `{ stdenv, fetchurl }:` fails.
7. **Supported systems are explicit** in `flake.nix` (`x86_64-linux`, `aarch64-linux`, `aarch64-darwin`). An Intel Mac requires adding `x86_64-darwin` there and to package sources.
8. **Never edit `hardware.nix`** (generated) or change an existing `stateVersion`.
9. **New files request only the args they use** (`{ perSystem, ... }`, `{ hostName, ... }`), not `{ config, pkgs, ... }` boilerplate.
10. **New flake inputs** set `inputs.nixpkgs.follows = "nixpkgs"` when they take nixpkgs; lock with `nix flake lock` (adds new inputs only) and confirm `git diff flake.lock` touches nothing else.

## Verify every change

Flakes only see files git knows about — run `git add -N <new files>` before evaluating.

```bash
# NixOS system evaluates
nix eval --raw .#nixosConfigurations.nixos.config.system.build.toplevel.drvPath
# macOS system evaluates (on the Mac, `darwin-rebuild build --flake .#macbook` also builds it)
nix eval --raw .#darwinConfigurations.macbook.config.system.build.toplevel.drvPath
# Refactor proof: identical drvPath to HEAD means an identical system
nix eval --raw "git+file://$PWD?rev=$(git rev-parse HEAD)#nixosConfigurations.nixos.config.system.build.toplevel.drvPath"
# Shared home module on other platforms (no Mac needed; also simulates standalone)
.claude/skills/nix-dotfiles/scripts/eval-shared-home.sh aarch64-darwin
# Every output on every system, evaluation only
nix flake check --no-build --all-systems
```

- When a refactor changes the drvPath, explain it with `nix run nixpkgs#nix-diff -- <old.drv> <new.drv>` before calling it done.
- Do not run `nix flake check` without `--no-build` (it downloads every packaged app), `nix flake update`, or `nixos-rebuild`/`darwin-rebuild switch` unless the user asks. `nixos-rebuild build` and `darwin-rebuild build` are fine.
- **nixpkgs, nix-darwin, home-manager and nixvim must report the same release** (nix-darwin aborts on a mismatch, home-manager warns, nixvim drops renamed options). All four track unstable/master (nixvim `main`), so update them together: `nix flake update nixpkgs nix-darwin home-manager nixvim`, never one alone. Expect nixvim option renames after an update (e.g. `diagnostics` → `diagnostic.settings`, `autopairs` → `nvim-autopairs`).
- Known harmless warnings: `unknown flake output '__functor'/'modules'/'mkPackagesFor'` (blueprint extras) and `Git tree is dirty`. Any other evaluation warning is new and worth fixing.
- On the Mac, Apple's Command Line Tools are removed, so `/usr/bin/git`, `python3`, `clang` are stubs that fail and pop an install dialog. Put Nix first on PATH in tool shells: `/etc/profiles/per-user/ishak/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin`, and run Python via `nix shell nixpkgs#python3`.
- Format only touched files: `nix shell nixpkgs#nixfmt -c nixfmt <files>`.

## Commits

One logical change per commit, conventional lowercase subject (`feat:`, `fix:`, `refactor:`, `chore:`), no body needed. The user is the sole author: never add a `Co-Authored-By` trailer or mention AI. Commits are GPG-signed; if signing fails, stop and report instead of disabling it.
