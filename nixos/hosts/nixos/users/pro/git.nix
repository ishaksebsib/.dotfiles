{ config, ... }:
{
  programs.git = {
    enable = true;

    signing = {
      key = "A9615445597FD76B";
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
