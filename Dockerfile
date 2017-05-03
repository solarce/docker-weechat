FROM ubuntu:xenial
MAINTAINER Brandon Burton brandon@inatree.org

RUN \
  export DEBIAN_FRONTEND=noninteractive ;\
  apt-get -q -y update ;\
  bash -c "echo 'deb https://weechat.org/ubuntu xenial main' >/etc/apt/sources.list.d/weechat.list" ;\
  apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E ;\
  apt-get install apt-utils apt-transport-https -y ;\
  apt-get -q -y update ;\
  apt-get install -q -y python-software-properties python-pip ;\
  apt-get install -q -y locales openssh-server tmux ;\
  apt-get install -q -y weechat-curses weechat-plugins ;\
  apt-get install -q -y mosh ;\
  mkdir /var/run/sshd ;\
  useradd -m docker -s /bin/bash ;\
  pip install websocket-client ;\
  locale-gen en_US.UTF-8

# SSH port
EXPOSE 22

# Mosh UDP ports
EXPOSE 60000-60050/UDP

# Weechat api relay port
EXPOSE 9001

# Weechat irc relay port
EXPOSE 9002

ADD bashrc /home/docker/.bashrc
ADD startup.sh /usr/bin/startup.sh

RUN chmod 755 /usr/bin/startup.sh

# The argument is the user as set up above
CMD ["/usr/bin/startup.sh", "docker"]
