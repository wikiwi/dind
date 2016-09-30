FROM docker:1.12-dind

LABEL org.label-schema.vcs-url="https://github.com/wikiwi/dind" \
      org.label-schema.vendor=wikiwi.io \
      org.label-schema.name=dind \
      io.wikiwi.license=MIT

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
CMD []

