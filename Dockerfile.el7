ARG centos=7.9.2009
ARG image=php-msgpack-7.4

FROM aursu/peclbuild:${centos}-${image}

RUN yum -y install \
        cyrus-sasl-devel \
        fastlz-devel \
        libevent-devel \
        memcached \
        zlib-devel \
    && yum clean all && rm -rf /var/cache/yum

RUN yum -y --enablerepo=bintray-custom install \
        libmemcached-devel \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER

ENTRYPOINT ["/usr/bin/rpmbuild", "php-pecl-memcached.spec"]
CMD ["-ba"]
