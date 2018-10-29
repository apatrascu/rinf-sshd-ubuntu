FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y \
    build-essential \
    curl \
    git \
    htop \
    iputils-ping \
    locales \
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

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
EXPOSE 22

RUN wget -q https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py -O /systemctl.py
RUN chmod +x /systemctl.py
RUN cp -f /systemctl.py /bin/systemctl
RUN cp -f /systemctl.py /usr/bin/systemctl

CMD /usr/sbin/sshd -D
