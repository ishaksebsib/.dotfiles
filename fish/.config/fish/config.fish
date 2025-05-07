# remove fish greeting
set fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# setup pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# set esc key to accept autosuggestion
bind \e accept-autosuggestion

# Set up fzf key bindings
fzf --fish | source

starship init fish | source

zoxide init fish --cmd cd | source
