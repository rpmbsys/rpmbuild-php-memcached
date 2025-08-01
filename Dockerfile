ARG os=10.0.20250606
ARG image=php-msgpack-8.4

FROM aursu/peclbuild:${os}-${image}

RUN dnf -y install \
        cyrus-sasl-devel \
        fastlz-devel \
        libevent-devel \
        libzstd-devel \
        memcached \
        zlib-devel \
    && dnf clean all && rm -rf /var/cache/dnf

RUN dnf -y --enablerepo=bintray-custom install \
        libmemcached-devel \
    && dnf clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER

ENTRYPOINT ["/usr/bin/rpmbuild", "php-pecl-memcached.spec"]
CMD ["-ba"]
