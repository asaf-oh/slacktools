#!/bin/bash

function usage
{
    echo "usage : $0"
    exit 0
}

function help
{
    echo "usage : $0"
    exit 0
}

function error
{
    echo "$0 : error : $1" >&2
    exit 10
}

[[ "$1" =~ "--help" ]] && help

# parse command line:
until [ -z $1 ]; do
    case $1 in
	-C)
	    [ -z $2 ] && error "-C requires an argument"
	    cd $2 || error "could not chdir $2"
	    shift 2
	    ;;
	*) 
	    error "unknow argument - $1"
	    ;;
    esac
done

for dir in `find . -type d -maxdepth 1`; do
    mkdir SlackBuilds
done