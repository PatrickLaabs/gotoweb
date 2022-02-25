FROM alpine
EXPOSE 8080
COPY webtogo /usr/bin/webtogo
ENTRYPOINT ["/usr/bin/webtogo"]