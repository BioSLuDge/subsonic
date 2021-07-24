FROM openjdk:8-oraclelinux8

ENV SUBSONIC_VER "6.1.6"
ENV SUBSONIC_HOME "/config"
ENV SUBSONIC_DEFAULT_MUSIC_FOLDER "/music"
ENV SUBSONIC_DEFAULT_PODCAST_FOLDER "/music/podcast"
ENV SUBSONIC_DEFAULT_PLAYLIST_FOLDER "/playlists"

WORKDIR /subsonic

COPY run.sh ./

RUN curl -L https://sourceforge.net/projects/subsonic/files/subsonic/$SUBSONIC_VER/subsonic-$SUBSONIC_VER-standalone.tar.gz/download > subsonic-standalone.tgz; \
        tar -xzf subsonic-standalone.tgz; \
        rm subsonic-standalone.tgz subsonic.bat Getting\ Started.html README.TXT; \
        mkdir /config; \
        mkdir -p /music/podcast; \
        mkdir /playlists; \
        chmod 755 run.sh

CMD ["./run.sh"]
