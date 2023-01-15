#!/usr/bin/env bash

# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.
 
for fgbg in 38 48 ; do # Foreground / Background
    for color in {0..255} ; do # Colors
        # Display the color
        printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
        # Display 6 colors per lines
        if [ $((($color + 1) % 6)) == 4 ] ; then
            echo # New line
        fi
    done
    echo # New line
done

echo 'For using one of the 256 colors on the foreground (text color), the control sequence is'
echo '    "<Esc>[38;5;ColorNumbermMyText"'
echo 'where ColorNumber is one of the previous colors.'
echo 'e.g.:'
echo 'echo -e "\e[38;5;82mHello \e[38;5;198mWorld\e[0m"'
echo -e "\e[38;5;82mHello \e[38;5;198mWorld\e[0m"
echo
echo '<Esc> in bash can be \e \033 or \x1B'
echo 'The "\e[0m" sequence removes all attributes (formatting and colors).'

echo "https://misc.flogisoft.com/bash/tip_colors_and_formatting"
exit 0
