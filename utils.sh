#!/bin/bash

SPELL_PATH="docs/**/*.md"

if [ -r venv/bin/activate ]; then
    source venv/bin/activate
else
    echo "You need to create venv - exiting"
    exit 1
fi

dev() {
    mkdocs serve -a 0.0.0.0:8001
}

build() {
    mkdocs build
}

case $1 in

build)
    build
;;

dev)
    dev
;;

sc)
    cspell "$SPELL_PATH"
;;

update-dictionary)
    cspell -u --words-only --quiet "$SPELL_PATH" > .cspell/custom-words.txt
;;

*)
    echo "Unsupported option"
;;

esac