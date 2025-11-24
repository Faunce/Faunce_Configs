if [ "$TMUX" = "" ]; then tmux; fi

export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/usr/local/go/bin

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
