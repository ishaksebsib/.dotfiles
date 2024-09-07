{ pkgs, ... }:
{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		oh-my-zsh = {
				enable = true;
				plugins = [ "git" ];
				theme = "robbyrussell";
		};

		plugins = [
      {
        name = "powerlevel10k-config";
        src = ../../dotfiles;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];

	};
}