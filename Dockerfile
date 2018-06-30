FROM alpine:3.7
LABEL maintainer "Fco. Javier Delgado del Hoyo <frandelhoyo@gmail.com>"

COPY ["run.sh", "backup.sh", "restore.sh", "/"]

ENV TZ=Asia/Shanghai

RUN apk update \
  && apk add bash mysql-client gzip tzdata \
  && cp /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ >  /etc/timezone \
  && rm -rf /var/cache/apk/* \
  && mkdir /backup \
  && chmod u+x /backup.sh /restore.sh

ENV CRON_TIME="0 0 1 * * ?" \
    MYSQL_HOST="mysql" \
    MYSQL_PORT="3306"

VOLUME ["/backup"]

CMD ["/run.sh"]
