#! /bin/bash

while true ;
do
    inotifywait -e modify -r ./src/*.tex ./figures/*.pdf ./src/*.bib
    make fast
done
