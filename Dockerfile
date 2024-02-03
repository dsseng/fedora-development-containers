FROM fedora
COPY code-server*.rpm /tmp/

RUN dnf install -y \
    curl \
    git \
    git-lfs \
    htop \
    nano \
    openssh-clients \
    procps \
    wget \
    zsh \
    dumb-init \
    glibc-locale-source \
    glibc-langpack-en \
  && git lfs install

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN dnf install -y /tmp/code-server*.rpm

ENV LANG=en_US.UTF-8
RUN echo 'LANG="en_US.UTF-8"' > /etc/locale.conf
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8

RUN adduser coder && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

RUN ARCH="$(uname -m | sed 's/x86_64/amd64/g' | sed 's/aarch64/arm64/g')" \
  && curl -fsSL "https://github.com/boxboat/fixuid/releases/download/v0.6.0/fixuid-0.6.0-linux-$ARCH.tar.gz" | tar -C /usr/local/bin -xzf - \
  && chown root:root /usr/local/bin/fixuid \
  && chmod 4755 /usr/local/bin/fixuid \
  && mkdir -p /etc/fixuid \
  && printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml

# Allow users to have scripts run on container startup to prepare workspace.
# https://github.com/coder/code-server/issues/5177
ENV ENTRYPOINTD=${HOME}/entrypoint.d

EXPOSE 8080
# This way, if someone sets $DOCKER_USER, docker-exec will still work as
# the uid will remain the same. note: only relevant if -u isn't passed to
# docker-run.
USER 1000
ENV USER=coder
WORKDIR /home/coder
ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
