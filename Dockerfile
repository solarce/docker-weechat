FROM ubuntu:15.10
MAINTAINER Philip Marc Schwartz philip@progmad.com 

RUN \
  apt-get -q -y update ;\
  apt-get install -y python-software-properties ;\
  apt-get install -y openssh-server weechat tmux ;\
  mkdir /var/run/sshd ;\
  useradd -m docker -s /bin/bash

EXPOSE 22

ADD bashrc /home/docker/.bashrc
ADD startup.sh /usr/bin/startup.sh

RUN chmod 755 /usr/bin/startup.sh

# The argument is the user as set up above
CMD ["/usr/bin/startup.sh", "docker"]
