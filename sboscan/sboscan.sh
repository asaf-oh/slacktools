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

function download
{
    wget --no-check-certificate $1 || error "wget returns $?"
    
}

[[ "$1" =~ "--help" ]] && help

[ $# -eq 1 ] || usage

case $1 in
  http://*|https://*|ftp://*)  
	download $1
	;;
 *.tar.*) 
	[ -f $1 ] || error "no such file $1"
	TARNAME=$1
	;;
    *)
	error "$1 is not a tarball or URL"
	;;
esac

name=`basename $1`
name=`echo $name | cut -f1 -d'-'`
version=`echo $1 | cut -f2 -d'-' | cut -d't' -f1`
version_len=${#version}
version=${version:0:$((version_len-1))}
echo $1 | cut -d't' -f2


