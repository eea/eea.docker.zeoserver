FROM eeacms/centos:7s
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

ENV ZEO_HOME=/opt/zeoserver

RUN curl https://bootstrap.pypa.io/get-pip.py | python3.4 && \
    pip3 install chaperone

RUN mkdir -p $ZEO_HOME

COPY src/base.cfg           $ZEO_HOME/base.cfg
COPY src/bootstrap.py       $ZEO_HOME/
COPY src/configure.py       /configure.py
COPY src/chaperone.conf     /etc/chaperone.d/chaperone.conf

WORKDIR $ZEO_HOME

RUN python bootstrap.py -v 2.2.1 --setuptools-version=7.0 -c base.cfg && \
    ./bin/buildout -c base.cfg && \
    groupadd -g 500 zope-www && \
    useradd -u 500 -g 500 -m -s /bin/bash zope-www && \
    chown -R 500:500 $ZEO_HOME

VOLUME $ZEO_HOME/var/

USER zope-www

ENTRYPOINT ["/usr/bin/chaperone"]
CMD ["--user", "zope-www"]
