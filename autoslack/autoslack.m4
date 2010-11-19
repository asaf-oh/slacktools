dnl
define(`AS_HEADER',
	 `#!/bin/sh
# Slackware build script for $1 $2
# Written by $3 <$4>')
dnl
dnl
define(`AS_VARS', 
`PRGNAM=$1
VERSION=${VERSION:-$2}
BUILD=${BUILD:-1}
TAG=${TAG:-_SBo}')
dnl
dnl
define(`AS_ARCH',
	`# Automatically determine the architecture we're building on:
if [ -z "$ARCH" ]; then
   uname=$( uname -m )
   if [ $uname ~= 'i?86' ]; then
      ARCH=i486
  elif[ $uname ~= 'arm*' ]; then    
      ARCH=arm
  else
    #Unless $ARCH is already set, use uname -m for all other archs:
      ARCH=$( uname -m )
fi')
dnl
dnl
define(`AS_DOWNLOAD',
	`if [ ! -f $CWD/PRGNAM-VERSION.TAREXT ]; then
  wget $1
fi')
dnl
define(`AS_PREPARE',
rm -rf $PKG
mkdir -p $TMP $PKG $OUTPUT
cd $TMP
rm -rf $PRGNAM-$VERSION
tar xvf CWD/PRGNAM-VERSION.tar.bz2
cd $PRGNAM-$VERSION
chown -R root:root .
find . \
 \( -perm 777 -o -perm 775 -o -perm 711 -o -perm 555 -o -perm 511 \) \
 -exec chmod 755 {} \; -o \
 \( -perm 666 -o -perm 664 -o -perm 600 -o -perm 444 -o -perm 440 -o -perm 400 \) \
 -exec chmod 644 {} \;')
dnl
dnl
dnl
AS_HEADER(PRGNAM, VERSION, AUTHOR, EMAIL)

AS_VARS(PRGNAM, VERSION)

AS_ARCH

set -e

AS_DOWNLOAD(DOWNLOAD)

AS_PREPARE