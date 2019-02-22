#
# coinmon Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV COINMON_VERSION 0.0.20

# Update & install packages
RUN apt-get update && \
    apt-get install -y git curl apt-transport-https

#Add yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Update & install packages
RUN apt-get update && \
    apt-get install -y yarn nodejs

# Clone the repository
RUN git clone https://github.com/bichenkk/coinmon.git

# Install
RUN cd coinmon && \
    yarn && \
    npm install -g && \
    npm link 

#Run it
RUN coinmon
