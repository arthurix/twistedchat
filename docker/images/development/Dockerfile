FROM ruby:2.3-slim

RUN apt-get update
RUN apt-get install -y --force-yes wget
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' \
  > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  apt-key add -

RUN apt-get update
RUN apt-get install -y --force-yes vim net-tools dpkg-dev libpq-dev nodejs postgresql-9.4

# Clean up apt when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER postgres
RUN    /etc/init.d/postgresql start &&\
    psql --command "ALTER USER postgres WITH PASSWORD '';"

USER root
RUN echo "local   all             postgres                                trust" > /etc/postgresql/9.4/main/pg_hba.conf
RUN echo "local   all             all                                     trust" >> /etc/postgresql/9.4/main/pg_hba.conf
RUN echo "host    all             all             127.0.0.1/32            trust" >> /etc/postgresql/9.4/main/pg_hba.conf
RUN echo "host    all             all             ::1/128                 trust" >> /etc/postgresql/9.4/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf
EXPOSE 5432
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
CMD ["/usr/lib/postgresql/9.4/bin/postgres", "-D", "/var/lib/postgresql/9.4/main", "-c", "config_file=/etc/postgresql/9.4/main/postgresql.conf"]
