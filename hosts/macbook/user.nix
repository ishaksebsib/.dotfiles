{ pkgs, ... }:
{
  system.primaryUser = "ishak";

  # knownUsers lets nix-darwin manage the existing account, which is what
  # makes the login shell below take effect; uid must match the account.
  users.knownUsers = [ "ishak" ];
  users.users.ishak = {
    uid = 501;
    home = "/Users/ishak";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
