# Rivendell 3.6.8 Qt5 port for Ubuntu 24.04

This branch uses Rivendell's upstream Qt5 conversion work but deliberately
retains database schema 347, the schema used by Rivendell 3.6.8. It is not a
Rivendell 4 database upgrade.

The upstream Qt5 conversion temporarily called its schema 348. That update did
not add, remove, or alter database objects; it only ran a schedule-code-rule
consistency check and recorded a new schema number. This branch removes that
version transition and continues to report and require schema 347.

## Build on a disposable Ubuntu 24.04 machine

Do not start with an on-air server. Clone the database and audio store first.

```sh
cd rivendell-v368-git
sudo ./ubuntu24/install-build-deps.sh
./ubuntu24/build.sh
```

For a reproducible compile-only check from another host:

```sh
docker build -f ubuntu24/Dockerfile -t rivendell-3.6.8-qt5 .
```

The initial build disables optional AudioScience HPI and MP4v2 support. ALSA,
JACK, FLAC, MAD, LAME, and TwoLAME are detected from the installed headers.

After a successful build, inspect the generated paths and install:

```sh
sudo make install
sudo ldconfig
sudo systemctl daemon-reload
```

Do not run `rddbmgr --modify` against production while validating the port.
The application should accept an existing schema-347 clone without proposing
an upgrade. Confirm this with `rddbmgr --check` and exercise read-only clients
before testing playout, capture, GPIO, switchers, replication, or web services.

## Compatibility contract

- Package identity: `3.6.8-qt5`
- Required database schema: `347`
- No schema-348 transition
- No Rivendell 4.x schema migrations
- Existing protocol and schema compatibility must be regression-tested against
  a CentOS 7 Rivendell 3.6.8 server before deployment
