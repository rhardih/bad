FROM rhardih/stand:r10e--android-21--arm-linux-androideabi-4.9

RUN apt-get update && apt-get -y install \
  wget

RUN wget -O proj-4.9.3.tar.gz http://download.osgeo.org/proj/proj-4.9.3.tar.gz && \
      tar -xzvf proj-4.9.3.tar.gz && \
      rm proj-4.9.3.tar.gz

WORKDIR /proj-4.9.3

ENV PATH $PATH:/android-21-toolchain/bin

RUN ./configure --host=arm-linux-androideabi --prefix=/proj-build/

RUN make && make install
