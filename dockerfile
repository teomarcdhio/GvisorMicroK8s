FROM alpine:3.19
RUN mkdir /local
COPY script.sh /
COPY containerd-template.toml /
RUN chmod u+x script.sh
CMD ["/script.sh"]