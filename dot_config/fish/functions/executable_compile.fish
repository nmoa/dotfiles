#!/usr/bin/fish

function compile
    argparse 's/sync' 'c/clean' 'm/dry-run-make' 'n/dry-run-sync' -- $argv
    or return
    if set -lq _flag_s
        set is_delete '--delete'
    end
    if [ $argv[1] = "." ];
        set dirname "."
        set dirname_sjis (basename "$PWD" | iconv -f utf8 -t sjis)
    else
        set dirname (basename $argv[1])/
        set dirname_sjis (basename "$dirname" | iconv -f utf8 -t sjis)
    end
    echo "$dirname"
    echo "$dirname_sjis"
    echo $is_delete
    if set -lq _flag_n
        rsync -avn $is_delete --exclude=".git" --exclude="build/*" "$dirname" "cd997:~/my_code/$dirname_sjis"
    else if set -lq _flag_m
        rsync -av $is_delete --exclude=".git" --exclude="build/*" "$dirname" "cd997:~/my_code/$dirname_sjis" && cocot -- ssh cd997 "cd my_code/$dirname_sjis/src; make -n $argv[2]"
    else if set -lq _flag_c
        rsync -av $is_delete --exclude=".git" --exclude="build/*" "$dirname" "cd997:~/my_code/$dirname_sjis" && cocot -- ssh cd997 "cd my_code/$dirname_sjis/src; make clean && lsfmake $argv[2]"
    else
        rsync -av $is_delete --exclude=".git" --exclude="build/*" "$dirname" "cd997:~/my_code/$dirname_sjis" && cocot -- ssh cd997 "cd my_code/$dirname_sjis/src; lsfmake $argv[2]"
    end
end
