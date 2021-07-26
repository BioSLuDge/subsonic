#!/bin/sh

if [ -z "${PUID}" ]; then
  PUID='1000'
fi

if [ -z "${PGID}" ]; then
  PGID='1000'
fi

if [ -e "${TZ}" ]; then
  echo "$TZ" > /etc/timezone
fi

addgroup -g $PGID -S subsonic
adduser -h /subsonic -u $PUID -G subsonic -S -D -H subsonic

chown subsonic:subsonic /config -R

export SUBSONIC_HOME=/config
export SUBSONIC_HOST=${SUBSONIC_HOST:-0.0.0.0}
export SUBSONIC_PORT=${SUBSONIC_PORT:-4040}
export SUBSONIC_HTTPS_PORT=${SUBSONIC_HTTPS_PORT:-0}
export SUBSONIC_CONTEXT_PATH=${SUBSONIC_CONTEXT_PATH:-/}
export SUBSONIC_DB=${SUBSONIC_DB}
export SUBSONIC_MAX_MEMORY=${SUBSONIC_MAX_MEMORY:-150}
export SUBSONIC_DEFAULT_MUSIC_FOLDER=${SUBSONIC_DEFAULT_MUSIC_FOLDER:-/data/music}
export SUBSONIC_DEFAULT_PODCAST_FOLDER=${SUBSONIC_DEFAULT_PODCAST_FOLDER:-/data/podcast}
export SUBSONIC_DEFAULT_PLAYLIST_FOLDER=${SUBSONIC_DEFAULT_PLAYLIST_FOLDER:-/data/playlists}

export JAVA=java
if [ -e "${JAVA_HOME}" ]; then
    export JAVA=${JAVA_HOME}/bin/java
fi

sudo -E -u subsonic sh -c '${JAVA} -Xmx${SUBSONIC_MAX_MEMORY}m \
  -Dsubsonic.home=${SUBSONIC_HOME} \
  -Dsubsonic.host=${SUBSONIC_HOST} \
  -Dsubsonic.port=${SUBSONIC_PORT} \
  -Dsubsonic.httpsPort=${SUBSONIC_HTTPS_PORT} \
  -Dsubsonic.contextPath=${SUBSONIC_CONTEXT_PATH} \
  -Dsubsonic.db="${SUBSONIC_DB}" \
  -Dsubsonic.defaultMusicFolder=${SUBSONIC_DEFAULT_MUSIC_FOLDER} \
  -Dsubsonic.defaultPodcastFolder=${SUBSONIC_DEFAULT_PODCAST_FOLDER} \
  -Dsubsonic.defaultPlaylistFolder=${SUBSONIC_DEFAULT_PLAYLIST_FOLDER} \
  -Djava.awt.headless=true \
  -verbose:gc \
  -jar subsonic-booter-jar-with-dependencies.jar'
