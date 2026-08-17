#!/bin/bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
  echo "Run this dependency installer with sudo." >&2
  exit 1
fi

. /etc/os-release
if [ "${ID:-}" != "ubuntu" ] || [ "${VERSION_ID:-}" != "24.04" ]; then
  echo "This script is intended for Ubuntu 24.04; found ${PRETTY_NAME:-unknown}." >&2
  exit 1
fi

apt-get update
apt-get install -y software-properties-common
add-apt-repository -y universe
apt-get update

apt-get install -y \
  autoconf automake autoconf-archive libtool pkg-config make g++ \
  qtbase5-dev qtbase5-dev-tools qttools5-dev-tools libqt5sql5-mysql \
  libexpat1-dev libssl-dev libvorbis-dev libsamplerate0-dev \
  libsndfile1-dev libcdparanoia-dev libdiscid-dev libmusicbrainz5-dev \
  libcoverart-dev libid3-3.8.3-dev libtag1-dev libcurl4-gnutls-dev \
  libpam0g-dev libsoundtouch-dev libasound2-dev libjack-jackd2-dev \
  libflac-dev libflac++-dev libmad0-dev libtwolame-dev libmp3lame-dev \
  libfaad-dev default-libmysqlclient-dev apache2 mariadb-client \
  python3 python3-pycurl python3-pymysql python3-serial python3-requests
