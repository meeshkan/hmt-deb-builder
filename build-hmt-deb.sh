#!/bin/sh
set -e -u

DEB_BUILD_DIR=/root/deb
rm -Rf $DEB_BUILD_DIR

# Setup /opt/hmt:
hmt_INSTALL_DIR=/opt/hmt
python3 -m venv $hmt_INSTALL_DIR
. $hmt_INSTALL_DIR/bin/activate
pip3 install hmt
hmt_VERSION=`pip3 show hmt | grep Version: | cut -d ' ' -f 2`
hmt_INSTALL_SIZE=`du -s $hmt_INSTALL_DIR`
deactivate

# Setup /usr/bin/hmt symlink inside build directory:
mkdir -p $DEB_BUILD_DIR/usr/bin
cd $DEB_BUILD_DIR/usr/bin
ln -s /opt/hmt/bin/hmt $DEB_BUILD_DIR/usr/bin/hmt

# Create data tarfile (containing /opt/hmt and /usr/bin/hmt):
cd $DEB_BUILD_DIR
mkdir opt
mv /opt/hmt opt/hmt
tar -cJf "/root/data.tar.xz" -H gnu .
mv /root/data.tar.xz $DEB_BUILD_DIR/

# Create debian control file:
mkdir -p $DEB_BUILD_DIR/DEBIAN
cat > $DEB_BUILD_DIR/DEBIAN/control <<EOF
Package: hmt
Architecture: all
Installed-Size: $hmt_INSTALL_SIZE
Maintainer: hmt <contact@hmt.com>
Version: $hmt_VERSION
Homepage: https://github.com/meeshkan/hmt
Depends: python3
Description: Tool that mocks HTTP APIs for use in sandboxes as well as for automated and exploratory testing.
EOF

# Create control.tar.gz:
cd $DEB_BUILD_DIR/DEBIAN
tar -czf "$DEB_BUILD_DIR/control.tar.gz" -H gnu .

# Create the .deb file:
cd $DEB_BUILD_DIR
echo "2.0" > debian-binary
hmt_DEB_FILE=/out/hmt-$hmt_VERSION.deb
ar cr $hmt_DEB_FILE debian-binary control.tar.gz data.tar.xz
echo "Created hmt-$hmt_VERSION.deb"
