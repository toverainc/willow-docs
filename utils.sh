#!/bin/bash

if [ -r venv/bin/activate ]; then
    source venv/bin/activate
else
    echo "You need to create venv - exiting"
    exit 1
fi

dev() {
    mkdocs serve -a 0.0.0.0:8001
}

case $1 in

dev)
    dev
;;

sc)
    cspell "docs/**.md"
;;

update-dictionary)
    cspell -u --words-only --quiet "docs/**.md" > .cspell/custom-words.txt
;;

*)
    echo "Unsupported option"
;;

esac