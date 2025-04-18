FROM node:latest

RUN apt-get update && \
  apt-get install -y sudo && \
  rm -rf /var/lib/apt/lists/*

# Allow the "node" user to use sudo without password
RUN touch /etc/sudoers.d/node
RUN echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/node

# Set the default group for the "node" user
RUN usermod -g users node

EXPOSE 9229
EXPOSE 80
