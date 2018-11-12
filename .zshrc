# .zshrc - github.com/bradcodes

# Set the prompt to something more pleasing
#PROMPT="%{$fg_bold[black]%}%(! %{$fg_bold[red]%} )>%{$fg_bold[black]%}%(1j %{$fg_bold[green]%} )>%{$fg_bold[black]%}%(?  %{$fg_bold[red]%})>%{$reset_color%} "
PS1='%F{green}%m %f%b%# '
RPROMPT='%F{pink}%~%f (%!)'

# Boring $PATH business:
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/bin:/usr/local/bin"
eval `dircolors -b $HOME/.dir_colors`

alias h="cd ~"
alias up="cd .."

# Distro agnostic package systems.
alias apt-get="sudo apt-get"
alias pacman='sudo pacman'
alias xi='sudo xbps-install'
alias apt='sudo apt'

# Taskbook specific
alias ctb='clear; tb'
alias ctbi='clear; tb -i'

# vim-style navigation
bindkey -v
bindkey -M viins ‘jk’ vi-cmd-mode
path+=('/usr/local/bin')
export PATH

# General purpose aliases
alias f='fzf'
alias ls="ls --color=auto"
alias cl="clear; ls"
alias vi='vim'
alias psa="ps aux"
alias kk="uname -mrs"
alias clp="clear;ls;pwd"
alias p3="ping -c 3"
alias treed="tree -Cd"
alias tree="tree -C"
alias tweet="rainbowstream"
alias sf="clear; sysinfo"
alias sfa='clear; echo; neofetch; echo;'
alias mem='top -l1 | grep PhysMem'
alias cat='bat'
alias dfc='clear; echo; dfc -Ms; echo;'

# For fun.
alias q='clear; quote; echo'
alias cow='clear; fortune | cowsay; echo'
alias tree='alder'

# Editing and sourcing .zshrc
alias zedit="vim ~/.zshrc"
alias zmouse="mousepad ~/.zshrc"
alias zsource="source ~/.zshrc"

# Git aliases
#alias g="git"
alias glog="git log"
alias gpretty="git log --pretty=oneline"
alias ggraph="git log --graph --oneline --decorate --all"

# Pomodoro
# function to start a timer in bg / pomodoro
alias pomo='doro'
function doro () {
    if [[ $# == 0 ]]; then
        let duration=1500           # no arguments -> 25 minutes
    else
        let duration=$(($1*60))
    fi
    sleep $duration
    (osascript -e 'tell application "System Events" to display dialog "Time for a water break!" buttons "OK" default button "OK"' && say "time up. STOP") &
}

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
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
