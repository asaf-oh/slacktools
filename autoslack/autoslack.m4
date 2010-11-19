include(conf.m4)
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
tar xvf CWD/PRGNAM-VERSION.$1
cd PRGNAM-VERSION
chown -R root:root .
find . \
 \( -perm 777 -o -perm 775 -o -perm 711 -o -perm 555 -o -perm 511 \) \
 -exec chmod 755 {} \; -o \
 \( -perm 666 -o -perm 664 -o -perm 600 -o -perm 444 -o -perm 440 -o -perm 400 \) \
 -exec chmod 644 {} \;')
dnl
define(`AS_CONFIGURE',
	`CFLAGS="$SLKCFLAGS" \
CXXFLAGS="$SLKCFLAGS" \
./configure \
  --prefix=/usr \
  --libdir=/usr/lib${LIBDIRSUFFIX} \
  --sysconfdir=/etc \
  --localstatedir=/var \
  --mandir=/usr/man \
  --docdir=/usr/doc/$PRGNAM-$VERSION \
  --build=$ARCH-slackware-linux \
  --disable-static')
dnl
define(`AS_STRIP',
	`find $PKG | xargs file | grep -e "executable" -e "shared object" | grep ELF \
  | cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null || true')
dnl
define(`AS_COPY_DOCS',
	`mkdir -p $PKG/usr/doc/$PRGNAM-$VERSION
cp -a \
  AUTHORS COPYING ChangeLog INSTALL NEWS README \
  $PKG/usr/doc/$PRGNAM-$VERSION
cat $CWD/$PRGNAM.SlackBuild > $PKG/usr/doc/$PRGNAM-$VERSION/$PRGNAM.SlackBuild')
dnl
define(`AS_MAKEPKG',
	`mkdir -p $PKG/install
cat $CWD/slack-desc > $PKG/install/slack-desc

cd $PKG
/sbin/makepkg -l y -c n $OUTPUT/$PRGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz}')
