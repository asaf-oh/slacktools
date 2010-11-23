include(conf.m4) dnl
define(`AS_HEADER',
	 `#!/bin/sh
# Slackware build script for $1 $2
# Written by $3 <$4>') dnl
define(`AS_LICENSE_SLACKWARE',
	`#
## Copyright  2010  $1, <$2>
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
') dnl
define(`AS_VARS', 
`PRGNAM=$1
VERSION=${VERSION:-$2}
BUILD=${BUILD:-1}
TAG=${TAG:-_SBo}

if [ -z "$ARCH" ]; then
   uname=$( uname -m )
   if [[ $ARCH =~ "i?86" ]]; then
      ARCH=i486
  elif [[ $ARCH =~ "arm*" ]]; then    
      ARCH=arm
  else
    #Unless $ARCH is already set, use uname -m for all other archs:
      ARCH=$( uname -m )
  fi
fi

CWD=$(pwd)
TMP=${TMP:-/tmp/SBo}
PKG=$TMP/package-$PRGNAM
OUTPUT=${OUTPUT:-/tmp}

if [ "$ARCH" = "i486" ]; then
  SLKCFLAGS="-O2 -march=i486 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "i686" ]; then
  SLKCFLAGS="-O2 -march=i686 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "x86_64" ]; then
  SLKCFLAGS="-O2 -fPIC"
  LIBDIRSUFFIX="64"
else
  SLKCFLAGS="-O2"
  LIBDIRSUFFIX=""
fi')dnl
define(`AS_CHECK_SLACKDESC',
	`if [ ! -f slack-desc ]; then
	echo "slack-desc is required" >&2
	exit 10
fi')dnl
define(`AS_DOWNLOAD',
	`if [ ! -f $CWD/$PRGNAM-$VERSION.$2 ]; then
  wget $1
fi')dnl
define(`AS_PREPARE',
`rm -rf $PKG
mkdir -p $TMP $PKG $OUTPUT
cd $TMP
rm -rf $PRGNAM-$VERSION
tar xvf $CWD/$PRGNAM-$VERSION.$1
cd $PRGNAM-$VERSION
chown -R root:root .
find . \
 \( -perm 777 -o -perm 775 -o -perm 711 -o -perm 555 -o -perm 511 \) \
 -exec chmod 755 {} \; -o \
 \( -perm 666 -o -perm 664 -o -perm 600 -o -perm 444 -o -perm 440 -o -perm 400 \) \
 -exec chmod 644 {} \;')dnl
define(`AS_CONFIGURE',
	`if [ ! -f "configure" ]; then
	./autogen.sh
fi
CFLAGS="$SLKCFLAGS" \
CXXFLAGS="$SLKCFLAGS" \
./configure \
  --prefix=/usr \
  --libdir=/usr/lib${LIBDIRSUFFIX} \
  --sysconfdir=/etc \
  --localstatedir=/var \
  --mandir=/usr/man \
  --docdir=/usr/doc/$PRGNAM-$VERSION \
  --build=$ARCH-slackware-linux \
  ifdef(`AS_CFG_CONFIGURE_FLAGS',  `AS_CFG_CONFIGURE_FLAGS \',`dnl')
  --disable-static')dnl
define(`AS_STRIP',
	`find $PKG | xargs file | grep -e "executable" -e "shared object" | grep ELF \
  | cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null || true')dnl
define(`AS_COPY_DOCS',
	`mkdir -p $PKG/usr/doc/$PRGNAM-$VERSION
cp -a \
  $1 \
  $PKG/usr/doc/$PRGNAM-$VERSION
cat $CWD/$PRGNAM.SlackBuild > $PKG/usr/doc/$PRGNAM-$VERSION/$PRGNAM.SlackBuild')dnl
define(`AS_MAKEPKG',
	`mkdir -p $PKG/install
cat $CWD/slack-desc > $PKG/install/slack-desc

cd $PKG
/sbin/makepkg -l y -c n $OUTPUT/$PRGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz}')dnl
dnl 	      slack-desc:
define(`AS_SLACKDESK_HELP',
		`# HOW TO EDIT THIS FILE:
# The "handy ruler" below makes it easier to edit a package description.  Line
# up the first "|" above the ":" following the base package name, and the "|"
# on the right side marks the last column you can put a character in.  You must
# make exactly 11 lines for the formatting to be correct.  Its also
# customary to leave one space after the ":". 
')dnl
define(`AS_SPACES', `    ')dnl
define(`AS_SLACKDESK_RULER',`AS_SPACES|-----handy-ruler------------------------------------------------------|')dnl