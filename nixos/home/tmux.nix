{ config, pkgs, fetchFromGitHub, ... }:
{
  programs.tmux = {
    enable = true;

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.resurrect
    ];

    extraConfig = ''
			unbind C-b
			set-option -g prefix M-a  # Set the prefix key to Alt + a
			bind-key M-a send-prefix  # Bind Alt + a to send the prefix key
			set -g status-style 'bg=default,fg=default'
			set -g base-index 1 

			# --
			set-window-option -g mode-keys vi
			bind -T copy-mode-vi v send-keys -X begin-selection
			bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

			# vim-like pane switching
			bind -r ^ last-window
			bind -r k select-pane -U
			bind -r j select-pane -D
			bind -r h select-pane -L
			bind -r l select-pane -R

    '';
  };
}
