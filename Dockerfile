FROM alpine:3.14

ENV SUBSONIC_VER "6.1.6"

WORKDIR /subsonic

COPY run.sh ./

RUN  apk update \
  apk upgrade; \
  apk add --no-cache openjdk8 lame ffmpeg flac curl sudo tzdata; \
  curl -L https://sourceforge.net/projects/subsonic/files/subsonic/$SUBSONIC_VER/subsonic-$SUBSONIC_VER-standalone.tar.gz/download > subsonic-standalone.tgz; \
  tar -xzf subsonic-standalone.tgz; \
  rm subsonic-standalone.tgz subsonic.bat Getting\ Started.html README.TXT subsonic.sh; \
  mkdir /config; \
  mkdir -p /music/podcast; \
  mkdir /playlists; \
  chmod 500 run.sh; \
  apk del curl; \
  rm -rf /var/cache/apk/*

CMD ["./run.sh"]
