
FROM ubuntu:22.04 as args

RUN mkdir -p /home/test && adduser --disabled-password --gecos '' test
RUN chown -c test /home/test
RUN adduser test sudo

RUN apt-get update && apt-get install -y nano buildah docker openssh-server podman ca-certificates && update-ca-certificates

RUN mkdir /var/run/sshd
RUN echo 'root:root123' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
