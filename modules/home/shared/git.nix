{ config, pkgs, ... }:
{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    # curses pinentry needs a tty, so GUI apps signing commits on macOS would fail
    pinentry.package =
      if pkgs.stdenv.hostPlatform.isDarwin then pkgs.pinentry_mac else pkgs.pinentry-curses;
    extraConfig = ''
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };

  programs.git = {
    enable = true;

    # signing.key is per machine: each host's home-configuration.nix sets its own
    signing = {
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

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      side-by-side = true;
      line-numbers = true;
      navigate = true;
      dark = true;
    };
  };
}
