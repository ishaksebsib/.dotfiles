# Custom packages (`packages/<pname>/default.nix`)

Use only for software missing from nixpkgs and flake inputs. GUI apps here are Linux-only for now (macOS is pure Nix with no Homebrew; ask the user before adding a darwin build); CLI tools carry a source for every platform upstream publishes (see `herdr`).

## Skeleton

```nix
{ pkgs, ... }:
let
  inherit (pkgs) lib stdenvNoCC;
  pname = "tool";
  version = "1.2.3";

  # where new versions are published: <release page URL>
  sources = {
    x86_64-linux = { url = "https://.../tool-${version}-linux-x86_64"; hash = "sha256-..."; };
    aarch64-darwin = { url = "https://.../tool-${version}-macos-aarch64"; hash = "sha256-..."; };
  };

  system = pkgs.stdenv.hostPlatform.system;
  source = sources.${system} or (throw "${pname}: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  inherit pname version;
  src = pkgs.fetchurl source;
  dontUnpack = true;
  dontBuild = true;
  installPhase = ''
    runHook preInstall
    install -Dm755 "$src" "$out/bin/${pname}"
    runHook postInstall
  '';
  meta = {
    description = "...";
    homepage = "...";
    license = lib.licenses.mit;            # lib.licenses.unfree when true
    platforms = builtins.attrNames sources; # keeps packages.<sys> and checks honest
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = pname;
  };
}
```

Consume it from a one-purpose module: `home.packages = [ perSystem.self.<pname> ];`.

## Other shapes in the repo — copy the closest existing file

- **Electron `.deb`** (`claude-desktop`, `t3code`, `antigravity-hub`): unwrapped derivation with `dpkg`, `autoPatchelfHook`, `makeWrapper` and a `runtimeLibs` list. Extract with `dpkg-deb --fsys-tarfile | tar -x --no-same-owner --no-same-permissions` and delete the setuid `chrome-sandbox`. Then wrap in `pkgs.buildFHSEnv`, copying desktop files and icons and setting `passthru.unwrapped`.
- **AppImage** (`rustdesk`): `appimageTools.wrapType2`, with the desktop file and icon taken from `extractType2`.
- Patch desktop files with `substituteInPlace --replace-fail` so upstream changes fail loudly.

## Version bump

1. Change `version` (and any extra build IDs).
2. For **each** key in `sources`: `nix store prefetch-file <url>` and paste the SRI hash. Darwin sources cannot be built on Linux, so prefetching is the only check — never guess or `lib.fakeHash` them.
3. `nix build .#<pname>` and `nix flake check --no-build --all-systems`.
4. Commit `chore: update <pname>`.
