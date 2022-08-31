export VISUAL=nvim
export EDITOR="$VISUAL"
export GIT_PS1_SHOWDIRTYSTATE=1
source ~/.src/kube-ps1/kube-ps1.sh
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1) \n└─ ▶︎ [$?]\[\033[0m\] $(kube_ps1) \[\033[01;37m\]\$ \[\033[00m\]'
