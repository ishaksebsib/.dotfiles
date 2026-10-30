{ pkgs, perSystem, ... }:
let
  llm-pkgs = perSystem.llm-agents;

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
