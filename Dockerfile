FROM ubuntu
MAINTAINER Shawn Mix, @1activegeek

# global environment Settings
ENV \
PHOENIX_TOKEN="" \
PHOENIX_DOWNLOAD="https://downloads.druva.com/downloads/Phoenix/Linux/druva-phoenix-client-4.6.12-33654.amd64.deb"

# update/install packages
RUN \
apt-get update && \
apt-get install -y \
    curl \
    libglib2.0.0 && \

# fix locales
# echo "LANG=en_US.UTF-8" >> "/etc/environment" && \

# phoenix install
curl -o \
  /tmp/phoenix-client.deb -L \
  ${PHOENIX_DOWNLOAD} && \
  dpkg -i /tmp/phoenix-client.deb && \

# cleanup
apt-get clean && \
apt-get remove -y --purge curl && \
apt autoremove -y && \
rm -rf \
  /tmp/* && \
rm -rf /var/lib/apt/lists/*

# Set working directory to run PhoenixActivate command
WORKDIR /opt/Druva/Phoenix/lib

# Create mountable volume for data to backup
VOLUME /opt/data

# run activation of client
ENTRYPOINT ["Phoenix", "-d"]
