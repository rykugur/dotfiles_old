command archey
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.bashrc_colors

#export LANG=en_US.UTF-8
#export PS1=" ${Blue}┌\n┌┤${Color_Off}${BIBlue}[${Color_Off}${UBlue}\u${Color_Off}${BIBlue}]${Color_Off} ${BIBlue}[${Color_Off}${UBlue}\h${Color_Off}${BIBlue}]${Color_Off} ${BIBlue}[${Color_Off}${UBlue}\t${Color_Off}${BIBlue}]${Color_Off} ${BIBlue}[${Color_Off}${UBlue}\w${Color_Off}${BIBlue}]${Color_Off}\n${Blue}│└\n└──────>${Color_Off} "
#export PS1=" ${Blue}┌─────────────────────\n┌┤${Color_Off}${LightGray} \u ${Blue}|${LightGray} \h ${Blue}|${LightGray} \t ${Blue}|${LightGray} \w${Color_Off}\n${Blue}│└─────────────────────\n└──────>${Color_Off} "
export PS1="${Blue}[ ${Color_Off}${LightGray}\u ${Blue}|${LightGray} \h ${Blue}|${LightGray} \t ${Blue}|${LightGray} \w${Color_Off}${Blue} ]${Color_Off}\n$ "
export EDITOR=nano
export PATH=$PATH:/home/dusty/bin

alias dircount='ls -l | wc -l'
alias dircountall='ls -al | wc -l'
alias df='df -h'
alias du='du -sh'
alias grep='grep --color=auto -i'
alias greppy='grep -niRE --color=auto'
alias ls='ls -h --color=auto'
alias mountiso='sudo mount -o loop -t iso9660'
alias steam='cd /home/dusty/.local/share/wineprefixes/steam/drive_c/Program\ Files/Steam'

bind "set completion-ignore-case on"

complete -cf sudo
complete -cf man
