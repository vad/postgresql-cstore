FROM postgres

WORKDIR /usr/src/postgres/contrib

RUN make -j"$(nproc)"
RUN make install

WORKDIR /usr/src/postgres

VOLUME /var/lib/postgresql/data
ENTRYPOINT ["/usr/src/postgres/docker-entrypoint.sh"]
EXPOSE 5432
CMD ["postgres"]
