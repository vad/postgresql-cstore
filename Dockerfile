FROM postgres:9.5

RUN apt-get update && \
    apt-get -y install protobuf-c-compiler libprotobuf-c0-dev unzip git build-essential

WORKDIR /usr/src/postgres/contrib

RUN make -j"$(nproc)" && make install

WORKDIR /usr/src
RUN git clone https://github.com/citusdata/cstore_fdw.git && \
    cd cstore_fdw && \
    RUN make -j"$(nproc)" && \
    make install && \
    cd .. && \
    rm -rf cstore_fdw

WORKDIR /usr/src/postgres

ENTRYPOINT ["/usr/src/postgres/docker-entrypoint.sh"]
