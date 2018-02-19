#! /bin/bash

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
function ctrl_c() {
    ./scripts/killall_launcher.sh
    exit 1
}

while true ;
do
    #inotifywait -e modify -r ./src/*.tex ./figures/*.pdf ./src/*.bib
    inotifywait -e modify ./src/*.tex ./src/header/*.tex
    make fast
done
