#!/bin/bash
set -euo pipefail

source_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$source_dir"

if [ ! -r /etc/os-release ]; then
  echo "Cannot identify the operating system." >&2
  exit 1
fi
. /etc/os-release
if [ "${ID:-}" != "ubuntu" ] || [ "${VERSION_ID:-}" != "24.04" ]; then
  echo "This build entry point is intended for Ubuntu 24.04; found ${PRETTY_NAME:-unknown}." >&2
  exit 1
fi

test "$(tr -d '\r\n' < PACKAGE_VERSION)" = "3.6.8-qt5"
grep -q '^#define RD_VERSION_DATABASE 347$' lib/dbversion.h

./autogen.sh
./configure \
  --prefix=/usr/local \
  --libexecdir=/var/www/rd-bin \
  --sysconfdir=/etc/apache2/conf-available \
  --disable-docbook \
  --disable-hpi \
  --disable-mp4v2

make -j"$(nproc)"

echo
echo "Build completed. Review ubuntu24/README.md before running sudo make install."
