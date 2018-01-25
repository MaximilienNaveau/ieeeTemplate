#! /bin/bash

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
function ctrl_c() {
    ./scripts/killall_launcher.sh
    exit 1
}

./script/make_document_launcher.sh &
./script/make_figure_launcher.sh &

while true ;
do
    read -n1 -r -p "Press ctrl-c key to end the program..." -t 1.0 key
    sleep 300
done

./killall_launcher.sh
