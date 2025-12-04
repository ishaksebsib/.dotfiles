# remove fish greeting
set fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# setup cargo
set -gx PATH $PATH $HOME/.cargo/bin

# setup bun
set -gx PATH $PATH $HOME/.bun/bin

# setup go
set -gx PATH $PATH (go env GOPATH)/bin

# setup pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# setup flyctl
set -gx FLYCTL_INSTALL "$HOME/.fly"
set -gx PATH "$FLYCTL_INSTALL/bin" $PATH

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


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/pro/.opam/opam-init/init.fish' && source '/home/pro/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
