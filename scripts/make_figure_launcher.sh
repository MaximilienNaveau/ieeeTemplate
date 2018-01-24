#! /bin/bash

while true ;
do
    inotifywait -e modify -r ./figures/tikz/*.tex
    make figures
done
