# ---------------------------------------------------------------------------
# +----------------+-----------+-----------+------+
# |                |Interactive|Interactive|Script|
# |                |login      |non-login  |      |
# +----------------+-----------+-----------+------+
# |/etc/profile    |   A       |           |      |
# +----------------+-----------+-----------+------+
# |/etc/bash.bashrc|           |    A      |      |
# +----------------+-----------+-----------+------+
# |~/.bashrc       |           |    B      |      |
# +----------------+-----------+-----------+------+
# |~/.bash_profile |   B1      |           |      |
# +----------------+-----------+-----------+------+
# |~/.bash_login   |   B2      |           |      |
# +----------------+-----------+-----------+------+
# |~/.profile      |   B3      |           |      |
# +----------------+-----------+-----------+------+
# |BASH_ENV        |           |           |  A   |
# +----------------+-----------+-----------+------+
# |                |           |           |      |
# +----------------+-----------+-----------+------+
# |                |           |           |      |
# +----------------+-----------+-----------+------+
# |~/.bash_logout  |    C      |           |      |
# +----------------+-----------+-----------+------+
#
# Executes A, then B, then C, etc. The B1, B2, B3 means it executes only the first of those files found.
#
#
#  The file .profile sould be sourced via ~/.bash_profile
#  Also ~/.bash_profile sould contain your local configs
#  Note that seam
#
#  Description:  This file holds all my BASH configurations and aliases

#  Sections:
#  1.  Environment Configuration @ .profile
#  2.  Make Terminal Better (remapping defaults and adding functionality) @ .bashrc
#  3.  File and Folder Management @ .bashrc
#  4.  Searching @ .bashrc
#  5.  Process Management @ .bashrc
#  6.  Networking @ .bashrc
#  7.  System Operations & Information @ .bashrc
#  8.  Web Development @ .bashrc
#  9.  Reminders & Notes @ .bashrc
# 10.  OS specific @ .profile
#
#  ---------------------------------------------------------------------------
# TODO: Discover were you are with varibles like
#       $HOSTNAME
#       $USER
#       $OSTYPE
#       $MACHTYPE
ostype() { echo $OSTYPE | tr '[A-Z]' '[a-z]'; }

export SHELL_PLATFORM='unknown'

case "$(ostype)" in
  *'linux'*)
    SHELL_PLATFORM='linux'
    ;;
  *'darwin'*)
    SHELL_PLATFORM='osx'
    ;;
  *'bsd'*)
    SHELL_PLATFORM='bsd'
    ;;
esac

#   -------------------------------
#   1. ENVIRONMENT CONFIGURATION
#   -------------------------------

if [ "$TERM" == "xterm" ]; then
    # No it isn't, it's gnome-terminal
    export TERM=xterm-256color
fi

#   Change Prompt
#   ------------------------------------------------------------
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_SOFT_BLUE="\033[0;36m"
COLOR_WHITE="\033[0;37m"
COLOR_PINK="\033[1;33m"
COLOR_RESET="\033[0m"

#Define colors depending on the machine
case $HOSTNAME in
MBPaR* | iMac*)
  HOST_COLOR=$COLOR_SOFT_BLUE
  ;;
search6 | lip*)
  HOST_COLOR=$COLOR_RED
  ;;
*)
  HOST_COLOR=$COLOR_PINK
  ;;
esac

function git_color {
  local git_status="$(git status 2> /dev/null)"
# if [[ ! $(git status 2> /dev/null | grep 'working \w\+ clean')  ]]; then
  if [[ ! $(git status 2> /dev/null | grep 'working \(directory\|tree\) clean')  ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
#
  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "$branch"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "$commit"
  fi
}

function git_pull_check {
# if [[ $(git fetch --dry-run) =~ "remote" ]]; then echo " pull" ; fi
    echo ""
}

function git_prmp() {
    local gp=""
    if ( git status &> /dev/null ) ; then
        gp+="($(git_color 2> /dev/null)"                                                        # colors git status
        gp+="$(git_branch 2> /dev/null)$(git_pull_check 2> /dev/null)$COLOR_RESET)"             # prints current branch
    fi
    echo -e $gp
}

# Pronpt 1
prmp1_1="________________________________________________________________________________\n"
prmp1_1+="\[$COLOR_YELLOW\]\w$COLOR_RESET\] "                                                   # current folder
prmp1_1+="@ \[$HOST_COLOR\]\h$COLOR_RESET\] "                                                   # pc local name
prmp1_1+="\[$COLOR_GREEN\](\u)$COLOR_RESET\] "                                                  # user name
prmp1_1+="\[\$(git_color 2> /dev/null)\]"                                                       # colors git status
prmp1_1+="\$(git_branch 2> /dev/null) \$(git_pull_check 2> /dev/null)$COLOR_RESET\]"            # prints current branch
prmp1_1+="\n| \[$COLOR_YELLOW\]=>$COLOR_RESET\] "                                               # pronpt
prmp1_2="| \[$COLOR_YELLOW\]=>$COLOR_RESET\] "

# Pronpt 2
prmp2_1="\[$COLOR_YELLOW\]\w$COLOR_RESET\] "                                                    # current folder
prmp2_1+="@ \[$HOST_COLOR\]\h$COLOR_RESET\] "                                                   # pc local name
prmp2_1+="\[$COLOR_GREEN\](\u)$COLOR_RESET\] "                                                  # user name
prmp2_1+="\[\$(git_color 2> /dev/null)\]"                                                       # colors git status
prmp2_1+="\$(git_branch 2> /dev/null) \$(git_pull_check 2> /dev/null)$COLOR_RESET\]"            # prints current branch
prmp2_1+="\n\[$COLOR_YELLOW\]\$$COLOR_RESET\] "                                                 # pronpt
prmp2_2="\[$COLOR_YELLOW\]\$$COLOR_RESET\] "

# Pronpt 3
prmp3_1="\[$COLOR_GREEN\]\u$COLOR_RESET\]"                                                      # user name
prmp3_1+="@\[$HOST_COLOR\]\h$COLOR_RESET\] "                                                    # pc local name
prmp3_1+="\[$COLOR_YELLOW\]\w$COLOR_RESET\] "                                                   # current folder
prmp3_1+="(\[\$(git_color 2> /dev/null)\]"                                                      # colors git status
prmp3_1+="\$(git_branch 2> /dev/null)\$(git_pull_check 2> /dev/null)$COLOR_RESET\])"            # prints current branch
prmp3_1+="\n\[$COLOR_YELLOW\]\$$COLOR_RESET\] "                                                 # pronpt
prmp3_2="\[$COLOR_YELLOW\]\$$COLOR_RESET\] "

# Pronpt 4
prmp4_1="\[$COLOR_GREEN\]\u\[$COLOR_RESET\]"                                                    # user name
prmp4_1+=" (\[$HOST_COLOR\]\h\[$COLOR_RESET\]) "                                                # pc local name
prmp4_1+="\[$COLOR_YELLOW\]\w\[$COLOR_RESET\] "                                                 # current folder
prmp4_1+="\$(git_prmp)"                                                                         # prints current branch
prmp4_1+="\n\[$COLOR_YELLOW\]\$\[$COLOR_RESET\] "                                               # pronpt
prmp4_2="\[$COLOR_YELLOW\]\$\[$COLOR_RESET\] "

# Select a prontp
PS1=$prmp4_1
PS2=$prmp4_2

export PS1
export PS2

#   Set Paths
#   ------------------------------------------------------------
export PATH="$PATH:$HOME/.local/scripts"

#   Set Default Editor
#   ------------------------------------------------------------
type nvim >/dev/null 2>&1 && export EDITOR=nvim
#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
export BLOCKSIZE=1k

#   Add color to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced


export HISTSIZE=10000
export HISEFILESIZE=10000

# ================== iTerm Profile ==============
iTermColor() {
    iTerm_profile=""
    if [[ $1 =~ ^ttys0[0-1][0-9]$ ]]; then
        iTerm_profile=$1
    # Check if arg is int
    elif [[ $1 =~ ^[0-9]$ ]]; then
        iTerm_profile="ttys00$1"
    elif [[ $1 =~ ^[0-9][0-9]$ ]]; then
        iTerm_profile="ttys0$1"
    elif [[ $1 =~ ^[0-9][0-9]$ ]]; then
        iTerm_profile="ttys0$1"
    else
        # Set profile randomly from 0 to 9
        iTerm_profile=$(( $$ % 10 ))
        iTerm_profile="ttys00${iTerm_profile}"
    fi

    if [[ $iTerm_profile =~ ttys000 ]]; then
        iTerm_profile="Default"
    fi

    echo -e "\033]50;SetProfile=$iTerm_profile\a"
    echo -e "\033];$iTerm_profile\007"
}

if [ "$SSH_TTY" ]; then # This ensures that will not interfere with sftp and scp
     TTY_temp=$(tty)
     # TTY=${TTY_temp#*/*/}
     TTY=${TTY_temp#*/*/ttys}
     iTermColor "ttys${TTY}"
     echo "Current login: $(date) on $TTY"
     IFS_ORIGINAL=$IFS
fi

#   ---------------------------------------
#   OS specific
#   ---------------------------------------

if [[ $SHELL_PLATFORM =~ "osx" ]] ; then
  # ============ Brew request ===========
  export PATH="/usr/local/sbin:$PATH"
  export PATH="/usr/local/bin:/usr/local:$PATH"
  # =========== Bash Completion ===========
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  fi
fi
