FROM ghcr.io/linuxserver/baseimage-alpine:3.12

# set version label
ARG BUILD_DATE
ARG VERSION
ARG MEDUSA_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs,aptalca"

ENV LANG='en_US.UTF-8'

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	mediainfo \
	python3 \
	unrar && \
 echo "**** install app ****" && \
 mkdir -p \
	/app/medusa && \
 curl -o \
	/tmp/medusa.tar.gz -L \
	"https://api.github.com/repos/3OW/Medusa/tarball/master" && \
 tar xf /tmp/medusa.tar.gz -C \
	/app/medusa --strip-components=1

# copy local files 
COPY root/ /

# ports and volumes
EXPOSE 8081
VOLUME /config /downloads /tv
