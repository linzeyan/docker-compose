# Dockerfile - CentOS 7 - RPM version
# https://github.com/openresty/docker-openresty

ARG RESTY_IMAGE_BASE="centos"
ARG RESTY_IMAGE_TAG="7"

FROM ${RESTY_IMAGE_BASE}:${RESTY_IMAGE_TAG}

ARG RESTY_IMAGE_BASE="centos"
ARG RESTY_IMAGE_TAG="7"
ARG RESTY_LUAROCKS_VERSION="3.1.3"
ARG RESTY_RPM_FLAVOR=""
ARG RESTY_RPM_VERSION="1.15.8.2-1.el7"
ARG RESTY_RPM_ARCH="x86_64"

LABEL resty_image_base="${RESTY_IMAGE_BASE}"
LABEL resty_image_tag="${RESTY_IMAGE_TAG}"
LABEL resty_luarocks_version="${RESTY_LUAROCKS_VERSION}"
LABEL resty_rpm_flavor="${RESTY_RPM_FLAVOR}"
LABEL resty_rpm_version="${RESTY_RPM_VERSION}"
LABEL resty_rpm_arch="${RESTY_RPM_ARCH}"

RUN yum-config-manager --add-repo https://openresty.org/package/${RESTY_IMAGE_BASE}/openresty.repo \
    && yum install -y \
        gcc \
        gettext \
        git \
        lua-devel \
        make \
        openresty${RESTY_RPM_FLAVOR}-${RESTY_RPM_VERSION}.${RESTY_RPM_ARCH} \
        openresty-opm-${RESTY_RPM_VERSION} \
        openresty-resty-${RESTY_RPM_VERSION} \
        openssl \
        unzip \
    && cd /tmp \
    && curl -fSL https://luarocks.github.io/luarocks/releases/luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz -o luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz \
    && tar xzf luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz \
    && cd luarocks-${RESTY_LUAROCKS_VERSION} \
    && ./configure \
        --prefix=/usr/local/openresty/luajit \
        --with-lua=/usr/local/openresty/luajit \
        --lua-suffix=jit-2.1.0-beta3 \
        --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1 \
    && /usr/bin/make build \
    && /usr/bin/make install \
    && cd /tmp \
    && groupadd www && useradd -m -d /srv/www -g www www \
    && ln -sf /usr/local/openresty/nginx/conf /etc/nginx \
    && ln -sf /usr/local/openresty/nginx/logs /var/log/nginx \
    && ln -sf /usr/local/openresty/nginx/sbin/nginx /usr/sbin/nginx \
    && ln -sf /usr/local/openresty/luajit/bin/luarocks /usr/bin/luarocks \
    && mkdir -p /etc/nginx/{sites-available,sites-enabled,conf.d,ssl,lua} \
    && mkdir -p /var/lib/nginx /usr/local/openresty/nginx/{logs,fastcgi_temp,proxy_temp,scgi_temp,client_body_temp,uwsgi_temp} \
    && chown www:www -R /var/lib/nginx /usr/local/openresty/nginx/{logs,fastcgi_temp,proxy_temp,scgi_temp,client_body_temp,uwsgi_temp} \
    && /usr/bin/luarocks install lua-resty-auto-ssl \
    && /usr/bin/luarocks install lua-resty-iputils \
    && /usr/bin/luarocks install lua-cjson \
    && opm get jxskiss/ssl-cert-server \
    && mkdir -p /opt/cert-server/ \
    && yum remove -y make \
    && rm -rf luarocks-${RESTY_LUAROCKS_VERSION} luarocks-${RESTY_LUAROCKS_VERSION}.tar.gz \
    && yum clean all

# Unused, present for parity with other Dockerfiles
# This makes some tooling/testing easier, as specifying a build-arg
# and not consuming it fails the build.
ARG RESTY_J="1"

# Add additional binaries into PATH for convenience
#ENV PATH=$PATH:/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin

# Add LuaRocks paths
# If OpenResty changes, these may need updating:
#    /usr/local/openresty/bin/resty -e 'print(package.path)'
#    /usr/local/openresty/bin/resty -e 'print(package.cpath)'
ENV LUA_PATH="/usr/local/openresty/site/lualib/?.ljbc;/usr/local/openresty/site/lualib/?/init.ljbc;/usr/local/openresty/lualib/?.ljbc;/usr/local/openresty/lualib/?/init.ljbc;/usr/local/openresty/site/lualib/?.lua;/usr/local/openresty/site/lualib/?/init.lua;/usr/local/openresty/lualib/?.lua;/usr/local/openresty/lualib/?/init.lua;./?.lua;/usr/local/openresty/luajit/share/luajit-2.1.0-beta3/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/openresty/luajit/share/lua/5.1/?.lua;/usr/local/openresty/luajit/share/lua/5.1/?/init.lua"

ENV LUA_CPATH="/usr/local/openresty/site/lualib/?.so;/usr/local/openresty/lualib/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/openresty/luajit/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/usr/local/openresty/luajit/lib/lua/5.1/?.so"

# Copy nginx configuration files
COPY nginx /etc/nginx
ADD ssl-cert-server.tar.gz /opt/cert-server/
ADD run.sh /root/run.sh

EXPOSE 80 443 8080 8443
ENTRYPOINT ["/bin/bash", "-c", "/root/run.sh"]

# Use SIGQUIT instead of default SIGTERM to cleanly drain requests
# See https://github.com/openresty/docker-openresty/blob/master/README.md#tips--pitfalls
STOPSIGNAL SIGQUIT
