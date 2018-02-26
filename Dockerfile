FROM alpine:edge

ADD run.sh /run.sh
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && apk add --update cntlm && chmod +x /run.sh && rm -rf /var/cache/apk/*

ENV CNTLM_AUTH NTLMv2
ENV CNTLM_NO_PROXY "localhost, 127.0.0.*, 10.*, 192.168.*, *.local"

EXPOSE 3128

ENTRYPOINT ["/run.sh"]

CMD [""]
