FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y \
    curl \
    htop \
    net-tools \
    openssh-client \
    openssh-server \
    python \
    python-pip \
    python3 \
    python3-pip \
    sshpass \
    sudo \
    vim \
    wget
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
EXPOSE 22
CMD /usr/sbin/sshd -D
