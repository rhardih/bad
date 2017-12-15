FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

RUN apt-get update && apt-get -y install \
  wget \
  bzip2

RUN wget -O geos-3.6.2.tar.bz2 http://download.osgeo.org/geos/geos-3.6.2.tar.bz2 && \
      tar -xjvf geos-3.6.2.tar.bz2 && \
      rm geos-3.6.2.tar.bz2

WORKDIR /geos-3.6.2

ENV PATH $PATH:/android-21-toolchain/bin

RUN ./configure --host=arm-linux-androideabi --prefix=/geos-build/

RUN make && make install
