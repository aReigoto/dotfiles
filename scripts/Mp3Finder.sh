#!/usr/bin/env bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
argc=$#
regex=0
open=0
music_path="/Volumes/Dois.Tera/Music"
play_alongs_path='/Volumes/Dois.Tera/!Livros and Stuff/Play-A-Longs'
#play_alongs_path=/Volumes/Dois.Tera/\!Livros\ \&\ Stuff/Fakebooks
sheach_path="$music_path"
list=0
executetable="/Applications/VLC.app/Contents/MacOS/VLC"
usage="$(basename ${BASH_SOURCE[0]}) (-r | --regex) [-o | --open] [-e | --executetable] [-p | --path] [-l | --list] [-h | --help]

where:
    -r : regex to sheach
    -o : open files in vlc
    -e : open files with a provided executetable program
    -p : sheach on the path other then the default
    -b : sheach on default backing tracks folder
    -l : list results when opening the files
    -z : lazy option lists opens and uses a prebuild regex
    -h : show this help text

exemple:
$(basename ${BASH_SOURCE[0]}) -lo -r \".*conrad.*\.mp3\"
$(basename ${BASH_SOURCE[0]}) -z \".*conrad.*\.mp3\""

#Loop truu the ags
# If option expects an arg then must have : after
#	e.g r:
while getopts "h?r:obe:p:lz:" opt; do
    case $opt in
        r)
            regex="$OPTARG"
            echo "Appas $OPTARG"
            ;;
        o)
            open=1
            ;;
        p)
            sheach_path="$OPTARG"
			;;
		b)
			sheach_path="$play_alongs_path"
            ;;
        l)
            list=1
            ;;
		z)
			regex=".*$OPTARG.*\.(mp3|mp2|mp4|m4a|flac|ffp|aif|aiff|ape|wav|wma)"
			list=1
			open=1
			echo "Lazzy regex:"
			echo $regex
			echo
			;;
        e)
            executetable="$OPTARG"
            ;;
        h|\?)
            echo "$usage"
            exit 0
            ;;
    esac
done

# Set not used vars to $@
shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

# Debug
#echo "regex: $regex"
#echo "open: $open"
#echo "sheach_path: $sheach_path"
#echo "list: $list"
#echo "executetable: $executetable"
#echo "Not used args: $@"
#echo "Total args: $#"
#echo "argc: $argc"


if [[ $regex == 0 ]]; then
    echo "A regex must exist!"
    echo "$usage"
    exit 0
fi

if [[ $open == 0 ]]; then
    find -E "$sheach_path" -iregex "$regex" -exec printf "%s\n\n" "\"{}\"" \;
elif [[ $open == 1 ]] && [[ $list == 0 ]]; then
    find -E "$sheach_path" -iregex "$regex" -exec "$executetable" {} +
elif [[ $open == 1 ]] && [[ $list == 1 ]]; then
    echo "\--------------------------------------------------------/"
    # find "$sheach_path" -iregex "$regex" -exec "$executetable" {} + -exec echo -e "\"{}\"" \;
    find -E "$sheach_path" -iregex "$regex" -exec "$executetable" {} + -exec printf "\"%s\"\n\n" "{}" \;
    echo "/--------------------------------------------------------\\"
fi
