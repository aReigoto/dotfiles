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

ostype() { echo $OSTYPE | tr '[A-Z]' '[a-z]'; }

export SHELL_PLATFORM='unknown'

case "$(ostype)" in
  *'linux'*)
    SHELL_PLATFORM='linux'
    ;;
  *'darwin'*)
    SHELL_PLATFORM='macOS'
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
# https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html
# https://misc.flogisoft.com/bash/tip_colors_and_formatting
# Half of 16 color codes 
#   The Other half is a brither version and starts at 90m
COLOR_BLACK="\033[0;30m"
COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_BLUE="\033[0;34m"
COLOR_PINK="\033[0;35m"
COLOR_SOFT_BLUE="\033[0;36m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

#Define colors depending on the machine
case $HOSTNAME in
ndre* )
  HOST_COLOR=$COLOR_SOFT_BLUE
  ;;
search* | lip* | lx*)
  HOST_COLOR=$COLOR_RED
  ;;
*)
  HOST_COLOR=$COLOR_PINK
  ;;
esac

function git_color {
  local git_status="$(git status 2> /dev/null)"
  if [[ ! $git_status =~ "working "(directory|tree)" clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_BLUE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  # 2 Regex
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "$branch"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "$commit"
  fi
}

function git_prmp() {
    local gp=""
    if ( git status &> /dev/null ) ; then
        gp+="($(git_color 2> /dev/null)"                          # colors git status
        gp+="$(git_branch 2> /dev/null)$COLOR_RESET)"             # prints current branch
    fi
    echo -e $gp
}

# Prompt 1
prmp1_1="_________________________________________________________\n"
prmp1_1+="\[$COLOR_YELLOW\]\w$COLOR_RESET\] "                     # current folder
prmp1_1+="@ \[$HOST_COLOR\]\h$COLOR_RESET\] "                     # pc local name
prmp1_1+="\[$COLOR_GREEN\](\u)$COLOR_RESET\] "                    # user name
prmp1_1+="\$(git_prmp)"                                           # prints colored git info
prmp1_1+="\n| \[$COLOR_YELLOW\]=>$COLOR_RESET\] "                 # prompt
prmp1_2="| \[$COLOR_YELLOW\]=>$COLOR_RESET\] "

# Prompt 2
prmp2_1="\[$COLOR_YELLOW\]\w$COLOR_RESET\] "                      # current folder
prmp2_1+="@ \[$HOST_COLOR\]\h$COLOR_RESET\] "                     # pc local name
prmp2_1+="\[$COLOR_GREEN\](\u)$COLOR_RESET\] "                    # user name
prmp2_1+="\$(git_prmp)"                                           # prints colored git info
prmp2_1+="\n\[$COLOR_YELLOW\]\$$COLOR_RESET\] "                   # prompt
prmp2_2="\[$COLOR_YELLOW\]\$$COLOR_RESET\] "

# Prompt 3
prmp3_1="\[$COLOR_GREEN\]\u$COLOR_RESET\]"                        # user name
prmp3_1+="@\[$HOST_COLOR\]\h$COLOR_RESET\] "                      # pc local name
prmp3_1+="\[$COLOR_YELLOW\]\w$COLOR_RESET\] "                     # current folder
prmp3_1+="\$(git_prmp)"
prmp3_1+="\n\[$COLOR_YELLOW\]\$$COLOR_RESET\] "                   # prompt
prmp3_2="\[$COLOR_YELLOW\]\$$COLOR_RESET\] "

# Prompt 4
prmp4_1="\[$COLOR_GREEN\]\u\[$COLOR_RESET\] "                     # user name
prmp4_1+="(\[$HOST_COLOR\]\h\[$COLOR_RESET\]) "                   # pc local name
prmp4_1+="\[$COLOR_YELLOW\]\w\[$COLOR_RESET\] "                   # current folder
prmp4_1+="\$(git_prmp)"                                           # prints colored git info
prmp4_1+="\n\[$COLOR_YELLOW\]\$\[$COLOR_RESET\] "                 # prompt
prmp4_2="\[$COLOR_YELLOW\]\$\[$COLOR_RESET\] "

# 256 Color Prompt Genareted by USER and HOSTNAME vars 
USER_COLOR_256=$(python3 -c "print (int.from_bytes(\"$USER\".encode(), byteorder='big') % 256)")
HOST_COLOR_256=$(python3 -c "print (int.from_bytes(\"$HOSTNAME\".encode(), byteorder='big') % 256)")

prmp256_uh1="\[\e[38;5;${USER_COLOR_256}m\]\u\[\e[0m\] "
prmp256_uh1+="(\[\e[38;5;${HOST_COLOR_256}m\]\h\[\e[0m\]) "
prmp256_uh1+="\[\e[0;33m\]\w\[\e[0m\] "
prmp256_uh1+="\$(git_prmp)"
prmp256_uh1+="\n\[\e[0;33m\]$\[\e[0m\] "
prmp256_uh2="\[$COLOR_YELLOW\]\$\[$COLOR_RESET\] "

# Select a prompt
if [[ "$TERM" =~ 256color && $USER_COLOR_256 =~ ^([0-9]+)$ ]]; then
    PS1=$prmp256_uh1
    PS2=$prmp256_uh2
else 
    PS1=$prmp4_1
    PS2=$prmp4_2
fi

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
if [[ $SHELL_PLATFORM =~ macOS ]]; then  
  export CLICOLOR=1
  export LSCOLORS=gxfxcxdxbxegedabagaced
elif [[ $SHELL_PLATFORM =~ linux ]]; then
  LS_COLORS=$(echo $LS_COLORS | sed -re 's/di=[0-9;]+:/di=0;94:/' -e 's/ln=[0-9;]+:/ln=0;95:/' )
  export LS_COLORS
fi

export HISTSIZE=10000
export HISEFILESIZE=10000

# ================== iTerm Profile ==============
iTermColor() {

    iTerm_profile=""

    if [[ $1 =~ -(h|-help) ]] ; then 
      echo "Run with agrs [0-9] to change iTermProfile"
      echo "Running with out any args will set iTermProfile to a random [0-9]"
      echo "Run iTermColor 0 to set to Default iTermProfile"
    fi

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
        iTerm_profile=$(( $(date +%s) % 10 ))
        iTerm_profile="ttys00${iTerm_profile}"
    fi

    if [[ $iTerm_profile =~ ttys000 ]]; then
        iTerm_profile="Default"
    fi

    echo -ne "\033]50;SetProfile=$iTerm_profile\a"
    echo -ne "\033];$iTerm_profile\007"
}

iTermTabColorRGB() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

iTermTabColor() {
    # Using rgb values
    # green : r 57, g 197, b 77
    case $1 in
    green)
    iTermTabColorRGB 57 197 77
    ;;
    red)
    iTermTabColorRGB 270 60 83
    ;;
    orange)
    iTermTabColorRGB 227 143 10
    ;;
    blue)
    iTermTabColorRGB 45 157 232
    ;;
    *)
    echo -ne "\033]6;1;bg;*;default\a"
    esac
}

iTermTabTitle() {
  echo -ne "\033]0;"$*"\007"
}

# Colorize iTerm when in a ssh session 
if [ "$SSH_TTY" ]; then # This ensures that will not interfere with sftp and scp
     TTY_temp=$(tty)
     TTY=${TTY_temp#*/*/*/}
     iTermColor "${TTY}"
     iTermTabColor blue
     echo "Current login: $(date) on tty$TTY"
     IFS_ORIGINAL=$IFS
     unset TTY_temp
fi

#   ---------------------------------------
#   OS specific
#   ---------------------------------------

if [[ $SHELL_PLATFORM =~ "macOS" ]] ; then
  # ============ Brew request ===========
  export PATH="/usr/local/sbin:$PATH"
  export PATH="/usr/local/bin:/usr/local:$PATH"
  # =========== Bash Completion ===========
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  fi
fi
