FROM hpess/chef:latest
MAINTAINER Karl Stoney <karl@jambr.co.uk>

# Install pre-reqs
RUN yum -y install openssl openssl-devel libxml2 libxml2-devel gcc gcc-c++ && \
    yum -y clean all

RUN cd /usr/local/src && \
    wget --quiet http://sourceforge.net/projects/nzbget/files/nzbget-14.1.tar.gz && \
    tar -zxf nzbget-14.1.tar.gz && \
    cd /usr/local/src/nzb* && \
    ./configure --disable-curses && \
    make && \
    make install-strip && \
    rm -rf /usr/local/src/nzb*

COPY services/* /etc/supervisord.d/
COPY cookbooks/ /chef/cookbooks/

RUN useradd nzbget

RUN chown -R nzbget:nzbget /usr/local/share/nzbget && \
    chown nzbget:nzbget /usr/local/bin/nzbget && \
    chown nzbget:nzbget /usr/local/sbin/nzbgetd

EXPOSE 6789
EXPOSE 6791

ENV chef_node_name nzbget.docker.local
ENV chef_run_list nzbget 
