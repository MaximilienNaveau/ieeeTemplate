#! /bin/bash

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
function ctrl_c() {
    ./scripts/killall_launcher.sh
    exit 1
}

while true ;
do
    list_files=$(find figures -name '*.tex')
    if [ $list_files  ]
    echo "the files to watch are "$list_files
    inotifywait -e modify $list_files
    make figures
    sleep 0.1
done
