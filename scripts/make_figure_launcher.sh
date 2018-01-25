#! /bin/bash

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
function ctrl_c() {
    ./scripts/killall_launcher.sh
    exit 1
}

while true ;
do
    inotifywait -e modify -r ./figures/tikz/*.tex
    make figures
done
