FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

# List of available versions can be found at
# https://www.sqlite.org/src/taglist
ARG VERSION=3.21.0

RUN apt-get update && apt-get -y install \
  wget \
  tcl

RUN wget -O sqlite-$VERSION.tar.gz \
  https://www.sqlite.org/src/tarball/sqlite.tar.gz?r=version-$VERSION && \
  tar -xzvf sqlite-$VERSION.tar.gz && \
  rm sqlite-$VERSION.tar.gz

WORKDIR /sqlite

ENV PATH $PATH:/android-21-toolchain/bin

# Acquire newer versions of .guess and .sub files for configure

RUN wget -O config.guess \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.guess

RUN wget -O config.sub \
  https://raw.githubusercontent.com/gcc-mirror/gcc/master/config.sub

RUN ./configure --host=arm-linux-androideabi --prefix=/sqlite3-build/ \
  --disable-tcl

RUN make && make install
