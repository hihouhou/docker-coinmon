#
# coinmon Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV COINMON_VERSION=0.0.22

# Update & install packages
RUN apt-get update && \
    apt-get install -y gnupg2 git wget curl apt-transport-https

#Add yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Update & install packages
RUN apt-get update && \
    apt-get install -y yarn nodejs

# Clone the repository
RUN mkdir coinmon && \
    cd coinmon && \
    wget https://api.github.com/repos/bichenkk/coinmon/tarball/${COINMON_VERSION} -O ${COINMON_VERSION}.tar.gz && \
    tar xf  ${COINMON_VERSION}.tar.gz --strip-components=1

# Install
RUN cd coinmon && \
    yarn && \
    npm install -g && \
    npm link 

#Run it
RUN coinmon
