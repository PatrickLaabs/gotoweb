FROM alpine
EXPOSE 8080
COPY gotoweb /usr/bin/gotoweb
ENTRYPOINT ["/usr/bin/gotoweb"]