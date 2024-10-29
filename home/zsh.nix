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
        src = ../dotfiles;
        file = "p10k.zsh.conf";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];

	};

	programs.zsh.initExtra = ''
	# Add common paths
	export PATH="/usr/local/bin:$PATH"
	export PATH="/opt/bin:/opt/local/bin:$PATH"

	# SETUP UP FZF KEY BINDING AND FZY COMPLITION
	eval "$(fzf --zsh)"
	'';
}
