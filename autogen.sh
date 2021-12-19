#!/bin/sh

test -n "$srcdir" || srcdir=`dirname "$0"`/arch/i386
test -n "$srcdir" || srcdir=./arch/i386

olddir=`pwd`

cd $srcdir
PROJECT="MechaOS Mach Kernel"
TEST_TYPE=-f
FILE=include/mach/mach_host.h

test $TEST_TYPE $FILE || {
	echo "You must run this script in the top-level $PROJECT directory"
	exit 1
}

AUTORECONF=`which autoreconf`
if test -z $AUTORECONF; then
        echo "*** No autoreconf found, please install it ***"
        exit 1
fi

if test -z "$NOCONFIGURE"; then
        if test -z "$*"; then
                echo "I am going to run ./configure with no arguments - if you wish "
                echo "to pass any to it, please specify them on the $0 command line."
        fi
fi

rm -rf autom4te.cache

autoreconf --force --install --verbose || exit $?

cd "$olddir"
test -n "$NOCONFIGURE" || "$srcdir/configure" "$@"
