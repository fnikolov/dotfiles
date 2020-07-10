export VISUAL=nvim
export EDITOR="$VISUAL"
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1) \n└─ ▶︎ [$?]\[\033[0m\]\[\033[01;34m\] $(kube_ps1) \$\[\033[00m\] '
