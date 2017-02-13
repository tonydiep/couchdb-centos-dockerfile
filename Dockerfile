FROM centos

MAINTAINER Tony Diep

RUN yum update
RUN yum install autoconf autoconf autoconf-archive automake ncurses-devel curl-devel erlang-asn1 erlang-erts erlang-eunit erlang-os_mon erlang-xmerl help2man js-devel libicu-devel libtool perl-Test-Harness










# RUN yum install -y http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
# RUN yum install -y couchdb

# # configure couchdb
# RUN sed -i "s/;port/port/" /etc/couchdb/local.ini ; sed -i "s/;bind_address = 127.0.0.1/bind_address = 0.0.0.0/" /etc/couchdb/local.ini


# EXPOSE  5984

# CMD ["/bin/bash", "-e", "/usr/local/bin/couchdb", "start"]