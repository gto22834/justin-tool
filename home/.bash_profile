# source other config file
[ -f ~/.bashrc ] && . ~/.bashrc
[ -f ~/.git-bash-completion.sh ] && . ~/.git-bash-completion.sh
# OSX system
[ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion
export PATH=$PATH:.
# export PATH=$PATH:/usr/bin

export TEST_MODE=true

export CLICOLOR='true'
#export LSCOLORS=GxFxCxDxBxegedabagaced # default bsd color
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # default bsd color, but not bold, dark background.
#export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd # default linux color
export LSCOLORS='exfxcxdxbxegedabagacad'

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# brew
export PATH="/usr/local/sbin:$PATH"

alias l='ls -CF'
alias la='ls -A'
alias ls='ls -vG'
alias ll='ls -alF'
alias vi='vim'
# intead of (brew install tree)
# alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# for OSX to scan port open.
alias scanport='lsof -n -P -i TCP -s TCP:LISTEN'

alias flushdns='sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache'

# colorful man page
export PAGER="`which less` -s"
export BROWSER="$PAGER"
export LESS_TERMCAP_mb=$'\E[0;34m'
export LESS_TERMCAP_md=$'\E[0;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[0;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[0;33m'

# git branch last commit display
function git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo "("${ref#refs/heads/}") ";
}

function git_since_last_commit {
    now=`date +%s`;
    last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
    seconds_since_last_commit=$((now-last_commit));
    minutes_since_last_commit=$((seconds_since_last_commit/60));
    hours_since_last_commit=$((minutes_since_last_commit/60));
    minutes_since_last_commit=$((minutes_since_last_commit%60));

    echo "${hours_since_last_commit}h${minutes_since_last_commit}m ";
}

PS1="[\[\033[1;32m\]\w\[\033[0m\]] \[\033[0m\]\[\033[1;36m\]\$(git_branch)\[\033[0;33m\]\$(git_since_last_commit)\[\033[0m\]$ "


### Docker 相關 ###
# docker
alias ds='docker stats $(docker ps --format={{.Names}})'
# ------------------------------------
# Docker alias and function
# ------------------------------------
# Get latest container ID
alias dl="docker ps -l -q"
# Get container process
alias dps="docker ps"
# Get process included stop container
alias dpa="docker ps -a"
# Get images
alias di="docker images"
# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"
# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"
# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"
# Stop all containers
dstop() { docker stop $(docker ps -a -q); }
# Remove all containers
drm() { docker rm $(docker ps -a -q); }
# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
# Remove all images
dri() { docker rmi $(docker images -q); }
# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }
# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

alias npmlsg="npm list -g --depth=0 2>/dev/null"
alias npmls="npm list --depth=0 2>/dev/null"
alias brewski='brew update && brew upgrade && brew cleanup; brew doctor'

#######
# GFW #
#######

#alias cnpm="npm --registry=https://registry.npm.taobao.org \
#--cache=$HOME/.npm/.cache/cnpm \
#--disturl=https://npm.taobao.org/dist \
#--userconfig=$HOME/.cnpmrc"

alias ccurl="curl --socks5 127.0.0.1:1087"
alias cbrew="ALL_PROXY=socks5://127.0.0.1:1087 brew"

# drone
export DRONE_SERVER=
export DRONE_TOKEN=

# urlencode
function urlencode () {
  local tab="`echo -en "\x9"`"
  local i="$@";
  i=${i//%/%25}  ; i=${i//' '/%20} ; i=${i//$tab/%09}
  i=${i//!/%21}  ; i=${i//\"/%22}  ; i=${i//#/%23}
  i=${i//\$/%24} ; i=${i//\&/%26}  ; i=${i//\'/%27}
  i=${i//(/%28}  ; i=${i//)/%29}   ; i=${i//\*/%2a}
  i=${i//+/%2b}  ; i=${i//,/%2c}   ; i=${i//-/%2d}
  i=${i//\./%2e} ; i=${i//\//%2f}  ; i=${i//:/%3a}
  i=${i//;/%3b}  ; i=${i//</%3c}   ; i=${i//=/%3d}
  i=${i//>/%3e}  ; i=${i//\?/%3f}  ; i=${i//@/%40}
  i=${i//\[/%5b} ; i=${i//\\/%5c}  ; i=${i//\]/%5d}
  i=${i//\^/%5e} ; i=${i//_/%5f}   ; i=${i//\`/%60}
  i=${i//\{/%7b} ; i=${i//|/%7c}   ; i=${i//\}/%7d}
  i=${i//\~/%7e} 
  echo "$i";
}
