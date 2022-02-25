FROM alpine
EXPOSE 8080
COPY puppet_bolt_exec /usr/bin/webToGo
ENTRYPOINT ["/usr/bin/webToGo"]