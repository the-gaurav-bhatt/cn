#!/bin/bash

REPO=${REPO:-raghav-rama/cn-lab}
REMOTE=${REMOTE:-https://gitlab.com/${REPO}.git}
BRANCH=${BRANCH:-main}
DIRNAME=${DIRNAME:-~/cn-lab}

# Function to display help message
display_help() {
    echo "Usage: $0 [option]"
    echo
    echo "Options:"
    echo "-p1    Clone program 1"
    echo "-p2    Clone program 2"
    echo "-p3    Clone program 3"
    echo "-p4    Clone program 4"
    echo "-p5    Clone program 5"
    echo "-p6    Clone program 6"
    echo "-p7    Clone program 7"
    echo "-p8    Clone program 8"
    echo "-p9    Clone program 9"
    echo "-p10   Clone program 10"
    echo "default: Clone the entire repo"
    echo
}

# If no arguments were passed, display help and exit
if [ $# -eq 0 ]; then
    display_help
    exit 1
fi

clone() {
    mkdir "$DIRNAME"
    git init --quiet "$DIRNAME" && cd "$DIRNAME" \
    && git config core.eol lf \
    && git config core.autocrlf false \
    && git config fsck.zeroPaddedFilemode ignore \
    && git config fetch.fsck.zeroPaddedFilemode ignore \
    && git config receive.fsck.zeroPaddedFilemode ignore \
    && git config oh-my-zsh.remote origin \
    && git config oh-my-zsh.branch "$BRANCH" \
    && git remote add origin "$REMOTE" \
    && git fetch --quiet --depth=1 origin \
    && git checkout --quiet -b "$BRANCH" "origin/$BRANCH" || {
        [ ! -d "$DIRNAME" ] || {
        cd -
        rm -rf "$DIRNAME" 2>/dev/null
        }
        exit 1
    }
    if [ "$#" -ne 1 ]; then
        echo "Unknown program, cloning the entire repo at $DIRNAME"
        cd $DIRNAME
        exit 1
    fi
    dir_name="Program${1#p}"
    mkdir ~/"$dir_name"
    cd "$DIRNAME/$dir_name"
    for file in *
    do
        cat $file > ~/"$dir_name"/"$file"
        echo "$file copied to ~/$dir_name/$file"
    done
    cd ../
    rm -rf "$DIRNAME" 2>/dev/null
}

while [ $# -gt 0 ]; do
    case $1 in
        -p1) clone "p1" ;;
        -p2) clone "p2" ;;
        -p3) clone "p3" ;;
        -p4) clone "p4" ;;
        -p5) clone "p5" ;;
        -p6) clone "p6" ;;
        -p7) clone "p7" ;;
        -p8) clone "p8" ;;
        -p9) clone "p9" ;;
        -p10) clone "p10" ;;
        *) clone ;;
    esac
    shift
done
