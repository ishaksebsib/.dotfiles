{
  home.file = {
    ".config/nvim" = {
      source = ../dotfiles/nvim;
    };

		# qtile configs
		".config/qtile" = {
			source = ../dotfiles/qtile/qtile;
		};

		".config/dunst" = {
			source = ../dotfiles/qtile/dunst;
		};

		".config/rofi" = {
			source = ../dotfiles/qtile/rofi;
		};

		".config/picom" = {
			source = ../dotfiles/qtile/picom;
		};
  };
}
