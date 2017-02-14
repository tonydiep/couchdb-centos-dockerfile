FROM centos

MAINTAINER Tony Diep

RUN yum update -y

RUN yum -y install \
    autoconf \
    autoconf-archive \
    automake \
    curl-devel \
    gcc \
    gcc-c++ \
    glibc-devel \
    erlang-asn1 \
    erlang-erts \
    erlang-eunit \
    erlang-os_mon \
    erlang-xmerl \
    help2man \
    js-devel-1.8.5 \
    libicu-devel \
    libtool \
    make \
    openssl-devel \
    perl-Test-Harness \
    pwgen \
    wget
    
# Compile Erlang

RUN cd /tmp && \
wget http://erlang.org/download/otp_src_19.2.tar.gz

RUN cd /tmp && \
tar -xvzf otp_src_19.2.tar.gz

RUN cd /tmp/otp_src_19.2 && \
CFLAGS="-DOPENSSL_NO_EC=1" ./configure && \
make && \
make install

# Compile CouchDB

RUN cd /tmp && \
wget http://www-eu.apache.org/dist/couchdb/source/2.0.0/apache-couchdb-2.0.0.tar.gz


RUN cd /tmp && tar -xzvf apache-couchdb-2.0.0.tar.gz

RUN cd /tmp/apache-couchdb-2.0.0 && \
./configure && \
make && \
make release


# CouchDB 2.0 does not have an install script
# Manually copy it into /usr/local/lib as suggested by CouchDB compile script

RUN cp -r /tmp/apache-couchdb-2.0.0/rel/couchdb /usr/local/lib



RUN adduser --system \
        --no-create-home \
        --shell /bin/bash \
        couchdb

#RUN chown -R couchdb:couchdb /usr/local/var/lib/couchdb /usr/local/var/log/couchdb /usr/local/var/run/couchdb

# configure couchdb
#RUN sed -i "s/;port/port/" /usr/local/lib/couchdb/local.ini ; sed -i "s/;bind_address = 127.0.0.1/bind_address = 0.0.0.0/" /usr/local/lib/couchdb/local.ini

EXPOSE  5984

CMD ["/bin/bash", "-e", "/usr/local/lib/couchdb/bin/couchdb", "start"]
