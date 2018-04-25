FROM alpine
RUN mkdir /run/socky && apk update && apk add socat
ENV UID=0 GID=0 MODE=644
CMD while true; do socat -s UNIX-LISTEN:/run/socky/socket,unlink-early,user=$UID,group=$GID,mode=$MODE TCP:$HOST:$PORT; done
