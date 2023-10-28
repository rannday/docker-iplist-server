FROM alpine:latest
RUN apk add darkhttpd && \
  mkdir -p /var/www/iplists && \
  touch /var/www/iplists/index.html && \
  echo '<h1>Working!</h1>' > /var/www/iplists/index.html && \
  rm -rf /var/cache/apk/*

VOLUME /var/www/iplists

EXPOSE 80

CMD ["darkhttpd", "/var/www/iplists", "--port", "9001"]