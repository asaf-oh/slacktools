#!/bin/sh -e

# scan tarball / link to generate initial conf and slack-desc
# TODO:  generate or select apropriate SlackBuild.as

function usage
{
    echo "usage : $0 tarball | link"
    exit 0
}

function help
{
    echo "usage : $0 tarball | link"
    exit 0
}

function error
{
    echo "$0 : error : $1" >&2
    exit 10
}

[[ "$1" =~ "--help" ]] && help

[ $# -eq 1 ] || usage

case $1 in
  http://*|https://*|ftp://*)  download $1
	;;
 *.tar.*) echo "tarball"
	[ -f $1 ] || error "no such file $1"
	;;
    *)
	error "$1 is not a tarball or URL"
	;;
esac

echo -n "name : "
echo `basename $1` | cut -f1 -d'-'
echo -n "version : "
echo $1 | cut -f2 -d'-' # see substrings