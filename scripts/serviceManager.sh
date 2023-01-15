#!/usr/bin/env bash

# # # # # # # # # # # #
# Defining  Functions #
# # # # # # # # # # # #

myName="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

# sudoCheck()
# {
  if [[ $EUID -ne 0 ]]; then
    echo -e "Aborting the install process: This script must be run as root\n"
    return 1 2>/dev/null || exit 
  fi
# }

yes_or_no()
{
  #Possible argument for yes_or_no
  if [[ $1 =~ ^[yY](es)? ]] ; then
    return 0
  elif [[ $1 =~ ^[nN]o? ]] ; then
    return 1
  fi

  #Promp interaction
  unset yes_or_no_option
  read -p "Type Yes(y) or No(n) `echo $'\n> '`" yes_or_no_option
  if [[ $yes_or_no_option =~ ^[yY](es)? ]] ; then
    return 0
  elif [[ $yes_or_no_option =~ ^[nN]o? ]] ; then
    return 1
  else
    echo "Invalid option!"
    yes_or_no
  fi
}

#define options via flagged input arguments
while [[ $1 =~ ^- ]] ; do
  case $1 in
    -a | --all)
        ForceYes="yes"
        echo -e "\nNot implemeted currently executing all\n"
        return 1 2>/dev/null || exit
        shift
         ;;
    -s | --start)
        apachectl start
        mysql.server start
        brew services start dnsmasq
        ;;
    -s | --stop)
        apachectl stop
        brew services stop dnsmasq
        mysql.server stop
        subArray[5]=$2
        shift
        shift
        ;;
    -stts | --status)
        apachectl status
        mysql.server status
        brew services list
        dotOutStart=$2
        shift
        shift
        ;;
    -r | --restar)
        apachectl restart
        mysql.server restart
        brew services restart
        shift
        ;;
    -h | --help)
        echo -e "\nUsage:"
cat <<EOF 
[optional]
${myName} [-a] [-s] [-S] [-r] [-stts] 
        -a --all Aply to all serveices
        -s --start
        -S --stop
        -r --restart
        -stts --status 
  sudo apachectl [option]
  sudo brew services [option] dnsmasq
  mysql.server [option]
EOF

            return 1 2>/dev/null || exit
            ;;
        -*)
            echo "Error: Unknown option: $1" >&2
            return 1 2>/dev/null || exit
    esac
done

