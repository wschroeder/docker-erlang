FROM ubuntu:16.04
MAINTAINER William Schroeder <wschroeder@gmail.com>

WORKDIR /root
ENV ERLANG_VERSION=19.1.5

RUN apt-get update && \
    apt-get install --no-install-recommends -y locales && \
    dpkg-reconfigure locales && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN apt-get install --no-install-recommends --yes ca-certificates man curl git make gcc g++ m4 libncurses-dev autoconf xsltproc libssl-dev unixodbc-dev fop libxml2-utils libwxgtk3.0-dev freeglut3-dev openjdk-9-jdk-headless

RUN git clone --branch OTP-${ERLANG_VERSION} --depth 1 https://github.com/erlang/otp
ENV ERL_TOP=/root/otp

WORKDIR ${ERL_TOP}
RUN ./otp_build autoconf && \
    ./configure && \
    make && \
    make install && \
    make docs && \
    make install-docs

WORKDIR /root
RUN rm -rf ${ERL_TOP} && curl -o /usr/local/bin/rebar3 https://s3.amazonaws.com/rebar3/rebar3 && \
    chmod 755 /usr/local/bin/rebar3 && \
    apt-get clean && \
    apt-get remove $(dpkg -l | awk '{print $2}' | grep '\-dev') && \
    apt-get autoremove

CMD ["/bin/bash"]

