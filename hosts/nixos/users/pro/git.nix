{ config, pkgs, ... }:
{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
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

      core = {
        editor = "nvim";
        sshCommand = "ssh -i ~/.ssh/id_ed25519 -o IdentitiesOnly=yes -o AddKeysToAgent=yes";
      };
    };

    includes = [
      {
        condition = "gitdir:~/dev/work/nexrizen/";
        contents = {
          user = {
            name = "Ishak Sebsib";
            email = "ishak@nexrizen.com";
            signingKey = "~/.ssh/id_ed25519_github_nexrizen.pub";
          };

          gpg.format = "ssh";
          core.sshCommand = "ssh -i ~/.ssh/id_ed25519_github_nexrizen -o IdentitiesOnly=yes -o AddKeysToAgent=yes";
        };
      }
    ];

    ignores = [ ".jj" ];
  };
}
