# .zshrc - github.com/bradleyschelling
# Set the prompt to something more pleasing
PS1='%B%F{magenta}%m %f%b%# '
RPROMPT='%B%F{cyan}%~%f (%!)'

# Boring $PATH business:
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/bin:/usr/local/bin"

# Navigation
# Enable support for 'z'
. `brew --prefix`/etc/profile.d/z.sh
alias h="cd ~"
alias up="cd .."

# anybar functions
function anybar { echo -n $1 | nc -4u -w0 localhost ${2:-1738}; }

# Vim-style navigation
bindkey -v
bindkey -M viins ‘jk’ vi-cmd-mode
path+=('/usr/local/bin')
export PATH

# General purpose aliases
# !!! To be cleaned up later

# Brew aliases
alias bupdate="brew update"
alias bupgrade="brew upgrade"
alias cask="brew cask"

alias ls="ls -fG"
alias cl="clear; ls"
alias psa="ps aux"
alias kk="uname -mrs"
alias clp="clear;ls;pwd"
alias p3="ping -c 3"
alias treed="tree -Cd"
alias tree="tree -C"
alias tweet="rainbowstream"
alias sf="clear; echo; archey"
alias mem='top -l1 | grep PhysMem'

# Editing and sourcing .zshrc
alias zedit="vim ~/.zshrc"
alias zsource="source ~/.zshrc"

# Git aliases
alias g="git"
alias glog="git log"
alias gpretty="git log --pretty=oneline"
alias ggraph="git log --graph --oneline --decorate --all"

# open file in quicklook from cli
# !!! This is still all wonky.  Need to find a better solution.
alias ql="qlmanage -p"

# Move and follow file to new dir:
# Example (from ~) mvf test.txt ~/downloads will move the file
# to ~/downloads and cd to that directory.
function mvf {
  if [[ -d $*[-1] ]]; then
    mv $* && cd $*[-1]
  elif [[ -d ${*[-1]%/*} ]]; then
    mv $* && cd ${*[-1]%/*}
  fi
}
# Copy and follow file:
# Just like the mvf() function but this one only copies.
function cpf {
  if [[ -d $*[-1] ]]; then
    cp $* && cd $*[-1]
  elif [[ -d ${*[-1]%/*} ]]; then
    cp $* && cd ${*[-1]%/*}
  fi
}

# Change to whatever directory the Finder is in
cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

# Use alt+s to insert sudo

insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# Must be last in .zshrc
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
