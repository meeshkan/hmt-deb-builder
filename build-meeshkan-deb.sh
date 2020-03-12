#!/bin/sh
set -e -u

DEB_BUILD_DIR=/root/deb
rm -Rf $DEB_BUILD_DIR

# Setup /opt/meeshkan inside build directory:
MEESHKAN_INSTALL_DIR=$DEB_BUILD_DIR/opt/meeshkan
python3 -m venv $MEESHKAN_INSTALL_DIR
. $MEESHKAN_INSTALL_DIR/bin/activate
pip3 install meeshkan

# Setup /usr/bin/meeshkan symlink inside build directory:
mkdir -p $DEB_BUILD_DIR/usr/bin
cd $DEB_BUILD_DIR/usr/bin
ln -s /opt/meeshkan/bin/meeshkan $DEB_BUILD_DIR/usr/bin/meeshkan

# Create data tarfile:
cd $DEB_BUILD_DIR
tar -cJf "/root/data.tar.xz" -H gnu .
mv /root/data.tar.xz $DEB_BUILD_DIR/

# Create debian control file:
MEESHKAN_VERSION=`pip3 show meeshkan | grep Version: | cut -d ' ' -f 2`
MEESHKAN_INSTALL_SIZE=`du -s $MEESHKAN_INSTALL_DIR`
mkdir -p $DEB_BUILD_DIR/DEBIAN
cat > $DEB_BUILD_DIR/DEBIAN/control <<EOF
Package: meeshkan
Architecture: all
Installed-Size: $MEESHKAN_INSTALL_SIZE
Maintainer: Meeshkan <contact@meeshkan.com>
Version: $MEESHKAN_VERSION
Homepage: https://github.com/meeshkan/meeshkan
Depends: python3
Description: Tool that mocks HTTP APIs for use in sandboxes as well as for automated and exploratory testing.
EOF

# Create control.tar.gz:
cd $DEB_BUILD_DIR/DEBIAN
tar -czf "$DEB_BUILD_DIR/control.tar.gz" -H gnu .

# Create the .deb file:
cd $DEB_BUILD_DIR
echo "2.0" > debian-binary
MEESHKAN_DEB_FILE=/out/meeshkan-$MEESHKAN_VERSION.deb
ar cr $MEESHKAN_DEB_FILE debian-binary control.tar.gz data.tar.xz
echo "Created meeshkan-$MEESHKAN_VERSION.deb"
