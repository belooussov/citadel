FROM centos:7

ENV container docker
#ENV PG_DATA /var/lib/postgresql/9.4/main
ENV PG_DATA /var/lib/postgresql/9.6/main

RUN yum -y update
#RUN yum -y install https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-3.noarch.rpm
RUN yum -y install epel-release
RUN yum -y install deltarpm initscripts yum-utils
RUN yum -y install python-setuptools gcc rsync python-devel
RUN easy_install supervisor supervisor-stdout && mkdir -p /var/log/supervisor/
COPY artifacts/etc/supervisord.conf /etc/supervisord.conf

RUN yum -y install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm

RUN echo "centos" > /etc/debian_version
COPY artifacts/etc/yum.repos.d/tower.repo /etc/yum.repos.d/tower.repo
RUN yum -y install ansible-tower

VOLUME ["/sys/fs/cgroup","${PG_DATA}","/certs"]
EXPOSE 80 443

COPY artifacts/etc/supervisord.d/postgres.conf /etc/supervisord.d/postgresql.conf
COPY artifacts/usr/local/bin/run_postgresql.sh /usr/local/bin/run_postgresql.sh
RUN chmod +x /usr/local/bin/run_postgresql.sh
ENTRYPOINT ["/usr/bin/supervisord","--config=/etc/supervisord.conf"]
