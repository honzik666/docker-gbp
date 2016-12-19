FROM debian:jessie
MAINTAINER Jan Čapek <jan.capek@braiins.cz>
ENV DEBIAN_FRONTEND noninteractive
# Note: bash-completion is required by debian helper...
RUN apt-get update && apt-get -y install \
    git-buildpackage \
    lsb-release \
    bash-completion
