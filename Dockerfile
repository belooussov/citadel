FROM centos:7

RUN yum -y update
RUN yum -y install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
RUN yum -y install epel-release deltarpm initscripts
RUN yum -y install supervisor
COPY artifacts/tower.repo /etc/yum.repos.d/tower.repo
RUN yum -y install ansible-tower-server
RUN yum -y install ansible-tower-setup
RUN yum -y install ansible-tower-ui

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

EXPOSE 80 443

VOLUME /sys/fs/cgroup

#ENTRYPOINT ["/usr/sbin/init"]
ENTRYPOINT ["/usr/bin/ansible-tower-service"]
CMD ["start"]
