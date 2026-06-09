{
  config,
  pkgs,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  llm-pkgs = inputs.llm-agents.packages.${system};
in
{
  home.packages = [
    llm-pkgs.pi
    llm-pkgs.opencode
    llm-pkgs.codex
    #llm-pkgs.claude-code
  ];
}
