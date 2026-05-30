{ config, pkgs, ... }:
{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
    extraConfig = ''
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };

  programs.git = {
    enable = true;

    signing = {
      key = "921099A4B90623CA";
      signByDefault = true;
      format = "openpgp";
    };

    settings = {
      user = {
        name = "ishaksebsib";
        email = "ishaksebsib@gmail.com";
      };

      pull.rebase = true;
      push.default = "current";
      init.defaultBranch = "main";
      interactive.diffFilter = "delta --color-only";
      merge.conflictStyle = "zdiff3";

      core = {
        editor = "nvim";
        pager = "delta";
      };

      delta = {
        side-by-side = true;
        line-numbers = true;
        navigate = true;
        dark = true;
      };
    };

    ignores = [ ".jj" ];
  };
}
