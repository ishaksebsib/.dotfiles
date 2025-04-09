if status is-interactive
    # Commands to run in interactive sessions can go here
end

# set esc key to accept autosuggestion
bind \e accept-autosuggestion

# Set up fzf key bindings
fzf --fish | source

starship init fish | source

zoxide init fish --cmd cd | source
