export LS_ARGS="-N"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export LANGUAGE=en
export G_FILENAME_ENCODING="UTF8"

# plenty of terminals say they are xterm but aren't;  attempt to see if we're
# using a terminal which supports 256 color and set TERM to ~256color if we are
if [ "$TERM" = "xterm" ]; then
  if [ -z "$COLORTERM" ]; then
    case "$XTERM_VERSION" in
      "XTerm(256)") TERM="xterm=256color" ;;
      "XTerm(88)") TERM="xterm-88color" ;;
      "XTerm") ;;
      "truecolor") ;;
      "") ;;
      *)
        echo "Unrecognized XTERM_VERSION: $XTERM_VERSION"
        ;;
    esac
  else
    case "$COLORTERM" in
      "mate-terminal") TERM="xterm-256color" ;;
      "gnome-terminal") TERM="xterm-256color" ;;
      "truecolor") ;;
      *)
        echo "Unrecognized COLORTERM: $COLORTERM"
        ;;
    esac
  fi
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# GIT
# store colors
MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[01;33m\]"
BLUE="\[\033[00;34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[00;32m\]"
RED="\[\033[0;31m\]"
VIOLET='\[\033[01;35m\]'
 
function color_my_prompt {
  local __user_and_host="$GREEN\u@\h"
  local __cur_location="$BLUE\W"           # capital 'W': current directory, small 'w': full file path
  local __git_branch_color="$GREEN"
  local __prompt_tail="$VIOLET$"
  local __user_input_color="$LIGHT_GRAY"
  local __git_branch=$(__git_ps1); 
  
  # colour branch name depending on state
  if [[ "${__git_branch}" =~ "*" ]]; then     # if repository is dirty
      __git_branch_color="$RED"
  elif [[ "${__git_branch}" =~ "$" ]]; then   # if there is something stashed
      __git_branch_color="$YELLOW"
  elif [[ "${__git_branch}" =~ "%" ]]; then   # if there are only untracked files
      __git_branch_color="$LIGHT_GRAY"
  elif [[ "${__git_branch}" =~ "+" ]]; then   # if there are staged files
      __git_branch_color="$CYAN"
  fi
   
  # Build the PS1 (Prompt String)
  PS1="$__user_and_host $__cur_location$__git_branch_color$__git_branch $__prompt_tail$__user_input_color "
}
 
# configure PROMPT_COMMAND which is executed each time before PS1
export PROMPT_COMMAND=color_my_prompt
 
# if .git-prompt.sh exists, set options and execute it
if [ -f /usr/lib/git-core/git-sh-prompt ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_HIDE_IF_PWD_IGNORED=true
  GIT_PS1_SHOWCOLORHINTS=true
  . /usr/lib/git-core/git-sh-prompt
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	if [ "$OS" != "OSX" ]; then
		[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
		[ -e "$DIR_COLORS" ] || DIR_COLORS=""
		eval "`dircolors -b $DIR_COLORS`"
		alias ls="ls --color=auto -F $LS_ARGS"
	fi
	#alias dir='ls --color=auto --format=vertical'
	#alias vdir='ls --color=auto --format=long'
fi

# enable programmable completion features 
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

export EDITOR=vim

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

QUOTING_STYLE=literal

# Aliases
alias ll="ls -l"
alias la="ls -lA"
