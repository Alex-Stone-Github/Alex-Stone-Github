# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/alex/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# -----------------------------------------------
# aliases
alias vim="nvim"
# The prompt ?
setopt PROMPT_SUBST
#PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
PROMPT='%F{green}%*%f %F{white}%n@%m %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
#PROMPT='%F{green}%*%f %F{white}%n@%m %F{blue}%~%f %F{red}$(__git_ps1)%f$ '
