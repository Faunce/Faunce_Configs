# Auto start TMUX with ZSH and kill ZSH when TMUX dies - i may regret this at some point?
if [[ -z "$TMUX" ]]; then
    # Attach if session exists, otherwise create new
    tmux attach-session -t default || tmux new-session -s default
    # Exit zsh when tmux exits
    exit
fi

export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/usr/local/go/bin
export DISABLE_UPDATE_PROMPT=true
ZSH_THEME="custom-ys"


plugins=(git)

source $ZSH/oh-my-zsh.sh


# aliases

for alias_file in ~/.aliases/*.zsh; do
    if [ -f "$alias_file" ]; then
        source "$alias_file"
    fi
done

alias fd="fdfind"
alias bat="batcat"
