# Auto start TMUX with ZSH and kill ZSH when TMUX dies - i may regret this at some point?

# if [ "$TMUX" = "" ]; then tmux new-session; fi
if [ "$TMUX" = "" ]; then tmux new-session && exit; fi
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

