FROM alpine:latest

# Set environment variables.
ENV \
  PAGER=more \
  LISTENER_PORT=10001 \
  BAUD_RATE=9600

# Install packages.
RUN \
  apk --update add \
    build-base \
    git \
    libressl-dev && \
  rm -rf /var/cache/apk/*

# Install the ser2sock application.
RUN \
  cd /tmp && \
  git clone https://github.com/nutechsoftware/ser2sock.git && \
  cd ser2sock && \
  ./configure && \
  make && \
  cp ser2sock /usr/local/bin/ && \
  cp -R etc/ser2sock /etc/ && \
  cd .. && \
  rm -rf ser2sock

# Add files to the container.
COPY /src/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN \
  chmod +x /usr/local/bin/entrypoint.sh
 
# Expose the listener port
EXPOSE ${LISTENER_PORT}

# Set the entrypoint script.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
