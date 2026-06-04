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

    delta = {
      enable = true;
      options = {
        side-by-side = true;
        line-numbers = true;
        navigate = true;
        dark = true;
      };
    };

    settings = {
      user = {
        name = "ishaksebsib";
        email = "ishaksebsib@gmail.com";
      };

      pull.rebase = true;
      push.default = "current";
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";

      core.editor = "nvim";
    };

    ignores = [ ".jj" ];
  };
}
