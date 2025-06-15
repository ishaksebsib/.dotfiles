# remove fish greeting
set fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# setup cargo
set -gx PATH $PATH $HOME/.cargo/bin

# setup go
set -gx PATH $PATH (go env GOPATH)/bin

# setup pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# set esc key to accept autosuggestion
bind \e accept-autosuggestion

# Set up fzf key bindings
fzf --fish | source

starship init fish | source

zoxide init fish --cmd cd | source

# load secrets
# run chmod 600 .secrets.fish to make it only readable by user
if test -f ~/.config/fish/.secrets.fish
    source  ~/.config/fish/.secrets.fish
end
