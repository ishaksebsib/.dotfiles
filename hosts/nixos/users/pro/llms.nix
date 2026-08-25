{
  config,
  pkgs,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  llm-pkgs = inputs.llm-agents.packages.${system};

  claude-work = pkgs.writeShellScriptBin "claude-work" ''
    export CLAUDE_CONFIG_DIR="$HOME/.claude-work"
    exec ${llm-pkgs.claude-code}/bin/claude "$@"
  '';
in
{
  home.packages = [
    llm-pkgs.pi
    llm-pkgs.opencode
    llm-pkgs.codex
    llm-pkgs.claude-code
    claude-work
  ];
}
