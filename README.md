Based on https://github.com/jacobalberty/squid-docker with tweaks to get HTTPS proxy working.

This requires a self-signed CA cert so that the proxy can impersonate the target's SSL cert.

```
openssl req -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -keyout proxyCA.pem  -out proxyCA.pem
```

Then to run:

```
docker run --rm -it --volume /somewhere/proxyCA.pem:/etc/squid/ssl_cert/proxyCA.pem -p 3128:3128 dmaas/squid-https
```

To use the proxy, you'll need to inform the tool of the CA cert:

```
https_proxy=http://localhost:3128 curl -v https://www.dcine.com/ --http1.1 --cacert /somewhere/proxyCA.pem
```

Note: HTTP/2 does not work.
