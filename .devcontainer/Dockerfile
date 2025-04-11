FROM ubuntu:24.04
# The group ID to use for the "docker" group
ARG DOCKER_GID

# Install the basics
RUN apt-get update && \
  apt-get install -y sudo apt-transport-https ca-certificates curl locales \
    software-properties-common git pipx && \
  # Add Ansible
  add-apt-repository --yes --update ppa:ansible/ansible && \
  apt-get install -y ansible && \
  # Add docker
  curl -fsSL get.docker.com | bash && \
  # Cleanup
  rm -rf /var/lib/apt/lists/*

# Setup default locale
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Allow the "ubuntu" user to use sudo without password
RUN touch /etc/sudoers.d/ubuntu
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ubuntu

# Set the default group for the "ubuntu" user
RUN usermod -g users ubuntu

# Allow running docker without `sudo`
RUN groupmod -g $DOCKER_GID docker
RUN usermod -aG docker ubuntu

# Install ansible dev tools for the "ubuntu" user
USER ubuntu
RUN pipx ensurepath && pipx install --include-deps ansible-dev-tools
