FROM ubuntu:24.04 AS dependencies

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /src/rivendell

COPY ubuntu24/install-build-deps.sh /src/rivendell/ubuntu24/install-build-deps.sh
RUN ./ubuntu24/install-build-deps.sh

FROM dependencies AS build

COPY . /src/rivendell
RUN find . -type f \( -name '*.ac' -o -name '*.am' -o -name '*.m4' \
      -o -name '*.in' -o -name '*.sh' -o -name '*.pl' \
      -o -name 'PACKAGE_VERSION' \) -exec sed -i 's/\r$//' {} +
RUN ./ubuntu24/build.sh

CMD ["/bin/bash"]
