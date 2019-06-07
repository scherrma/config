test -f /etc/profile.dos && . /etc/profile.dos

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# add aliases if there is a .aliases file
test -s ~/.alias && . ~/.alias

shopt -s autocd

cores=$(cat /proc/cpuinfo | grep "processor" | wc -l)
set_bash_prompt() {
  usage=$(cat /proc/loadavg | awk -v cores="$cores" '{printf "%i", 50.0*($0+$1)/cores+0.5;exit}' )
  #usage=$(mpstat | awk 'FNR == 4 {printf "%i", 100.5-$12; exit}')
  #usage=$(top -bn 2 -d 0.01 | grep "Cpu" | awk 'FNR == 2 {printf "%i", 100.5-substr($0, 35, 5); exit}')
  noColor='\e[0m'
  if (("$usage" > "90")); then
    usageColor='\e[31m'
  elif (("$usage" > "70")); then
    usageColor='\e[33m'
  else
    usageColor='\e[32m'
  fi

  PS1="[\@] \[${usageColor}\]$usage%\[${noColor}\] \[\e[32m\]\u@\h \w> \[\e[m\]"
}
PROMPT_COMMAND=set_bash_prompt

# Swap 2 filenames around, if they exist (from Uzi's bashrc).
function swap() { 
  local TMPFILE=tmp.$$

  [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
  [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
  [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

  mv "$1" $TMPFILE
  mv "$2" "$1"
  mv $TMPFILE "$2"
}

# Handy Extract Program
function extract() {     
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1     ;;
      *.tar.gz)    tar xvzf $1     ;;
      *.bz2)       bunzip2 $1      ;;
      *.rar)       unrar x $1      ;;
      *.gz)        gunzip $1       ;;
      *.tar)       tar xvf $1      ;;
      *.tbz2)      tar xvjf $1     ;;
      *.tgz)       tar xvzf $1     ;;
      *.zip)       unzip $1        ;;
      *.Z)         uncompress $1   ;;
      *.7z)        7z x $1         ;;
      *)           echo "'$1' cannot be extracted with extract" ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

alias ls='ls --color -F'
alias ll='ls -lv --group-directories-first'
alias la='ll -a'

#cd and ls in one
function cl() {
  dir=$1
  if [[ -z "$dir" ]]; then
    dir=$HOME
  fi
  if [[ -d "$dir" ]]; then
    cd "$dir"
    ls
  else
    echo "bash: cl: '$dir': Directory not found"
  fi
}
alias cd='cl'
alias rm='rm -r'
alias cp='cp -r'
alias scp='scp -r'

eval "$(dircolors ~/.dir_colors)"
