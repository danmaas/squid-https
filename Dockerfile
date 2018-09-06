FROM jacobalberty/squid:3.5.28

RUN apt update && apt -qy install ca-certificates && \
  /usr/lib/squid/ssl_crtd -c -s /var/lib/ssl_db && \
  mkdir -p /var/spool/squid /var/log/squid && \
  chown nobody /var/spool/squid /var/log/squid /var/lib/ssl_db && \
  chmod -R 777 /var/log/squid /var/spool/squid /var/lib/ssl_db

COPY squid.conf /conf/squid.conf

CMD ["squid", "-NYC", "-f", "/conf/squid.conf"]
