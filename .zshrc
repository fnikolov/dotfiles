# Aliases
alias ll='ls -lG'
alias vim='nvim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FPATH="$HOME/.docker/completions:$FPATH"
autoload -Uz compinit
compinit

#Stops Tab completion from cycling through files.
setopt noautomenu

export KUBE_EDITOR=/opt/homebrew/bin/nvim

## kubectl completion
#autoload -Uz compinit
#source <(kubectl completion zsh)

## kube-ps1
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
export KUBE_PS1_SYMBOL_ENABLE=false

## zsh prompt
autoload -Uz vcs_info
precmd() {
  vcs_info
  print -P "%F{yellow}%~%f ${vcs_info_msg_0_}"
  #print -P "%F{yellow}┌" "%~%f ${vcs_info_msg_0_}"
}

zstyle ':vcs_info:git*' formats " %F{blue}%b%f %m%u%c %a "
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}✚%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'

#PROMPT='%F{yellow}%(!.#.└ $(kube_ps1)) $ %f'
PROMPT='%(!.#.└ $(kube_ps1)) $ %f'


## gardenctl completion
#gardenctl completion zsh > $(brew --prefix)/share/zsh/site-functions/_gardenctl
#source <(gardenctl completion zsh)

#gardener session setup
[ -n "$GCTL_SESSION_ID" ] || [ -n "$TERM_SESSION_ID" ] || export GCTL_SESSION_ID=$(uuidgen)

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# AWS completion
autoload bashcompinit && bashcompinit
#autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

fpath=($fpath ~/.zsh/completion)

