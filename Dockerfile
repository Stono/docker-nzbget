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

RUN chown -R docker:docker /usr/local/share/nzbget && \
    chown docker:docker /usr/local/bin/nzbget && \
    chown docker:docker /usr/local/sbin/nzbgetd

RUN cd /usr/local/src && \
    wget --quiet http://www.rarlab.com/rar/unrarsrc-4.2.4.tar.gz && \
    tar -zxf unrar* && \
    cd unrar && \
    cp makefile.unix Makefile && \
    make && \
    make install && \
    rm -rf /usr/local/src/unrar* 

EXPOSE 6789 6791

ENV chef_node_name nzbget.docker.local
ENV chef_run_list nzbget 

COPY services/* /etc/supervisord.d/
COPY cookbooks/ /chef/cookbooks/
