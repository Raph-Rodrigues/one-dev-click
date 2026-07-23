if test "$TERM" = xterm-kitty
    set -gx TERM xterm-256color
end

set -gx XDG_DATA_DIRS $HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

if status is-interactive
    # no greeting
    set fish_greeting

    # use starship
    if test "$TERM" != linux
        starship init fish | source
        enable_transience
        function starship_transient_prompt_func
            starship module character
        end
    end

    # aliases
    alias clear "printf '\033[2J\033[[3J\033[1;1H'"
    alias celar "printf '\033[2J\033[[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[[3J\033[1;1H'"
    alias pamcan pacman
    alias q 'qs -c ii'
    if test "$TERM" != linux
        alias ls 'eza -a --icons --group-directories-first'
    end
    if test "$TERM" = xterm-kitty
        alias ssh 'kitten ssh'
    end

    # fastfetch
    fastfetch

    # ASDF configuration code
    if test -z $ASDF_DATA_DIR
        set _asdf_shims "$HOME/.asdf/shims"
    else
        set _asdf_shims "$ASDF_DATA_DIR/shims"
    end

    # Do not use fish_add_path (added in Fish 3.2) because it
    # potentially changes the order of items in PATH
    if not contains $_asdf_shims $PATH
        set -gx --prepend PATH $_asdf_shims
    end
    set --erase _asdf_shims
end

# >>> conda initialize >>>
if test -f $HOME/anaconda3/bin/conda
    eval $HOME/anaconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "$HOME/anaconda3/etc/fish/conf.d/conda.fish"
        . "$HOME/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH $HOME/anaconda3/bin/ $PATH
    end
end

# <<< conda initialize <<<
