FROM bitnami/minideb:buster
LABEL maintainer="Arne Ludwig <ludwig@mpi-cbg.de>"

ARG NCPUS=1
ENV NCPUS=${NCPUS}
# Install dependencies (build & runtime) via apk
RUN apt-get update && \
    # install build dependencies
    install_packages \
        build-essential autoconf automake libtool pkg-config \
        git ca-certificates \
        zlib1g zlib1g-dev libgmp-dev libunwind-dev
# Provide our convenient build script to reduce verbosity
COPY ./build-and-install.sh /opt/

# Build runtime dependencies
RUN REPO=https://gitlab.com/german.tischler/libmaus2.git \
    BRANCH=2.0.724-release-20200702192714 \
    PREBUILD='autoupdate && autoreconf -i -f && ./configure --with-gmp && make' \
    INSTALL_CMD='make install' \
    /opt/build-and-install.sh libmaus2 make
RUN REPO=https://gitlab.com/german.tischler/daccord.git \
    BRANCH=0.0.18-release-20200702195851 \
    PREBUILD='autoreconf -i -f && ./configure --with-libmaus2=/usr/local' \
    INSTALL_CMD='make install' \
    /opt/build-and-install.sh daccord make
RUN install_packages build-essential git && \
    REPO=https://github.com/thegenemyers/DAZZ_DB.git \
    BRANCH=d22ae58d32a663d09325699f17373ccf8c6f93a0 \
    /opt/build-and-install.sh DAZZ_DB make
RUN REPO=https://github.com/thegenemyers/DASCRUBBER.git \
    BRANCH=a53dbe879a716e7b08338f397de5a0403637641e \
    /opt/build-and-install.sh DASCRUBBER make
RUN REPO=https://github.com/thegenemyers/DAMASKER.git \
    BRANCH=22139ff1c2b2c0ff2589fbc9cc948370be799827 \
    PREBUILD="sed -i -E 's/\\bDB_CSS\\b/DB_CCS/g' *.c *.h" \
    /opt/build-and-install.sh DAMASKER make
RUN REPO=https://github.com/thegenemyers/DALIGNER.git \
    BRANCH=c2b47da6b3c94ed248a6be395c5b96a4e63b3f63 \
    /opt/build-and-install.sh DALIGNER make
RUN REPO=https://github.com/thegenemyers/DAMAPPER.git \
    BRANCH=b2c9d7fd64bb4dd2dde7c69ff3cc8a04cbeeebbc \
    /opt/build-and-install.sh DAMAPPER make
COPY ./ /opt/dentist
RUN install_packages ldc dub jq && \
    REPO=https://github.com/a-ludi/dentist.git \
    BRANCH='' \
    BUILD=release \
    BUILD_CONFIG=dockerfile \
    /opt/build-and-install.sh dentist dub
RUN apt-get remove -y ldc dub jq
#  default-d-compiler dub jq ldc libbsd0 libedit2 libgphobos76 libjq1
#  libllvm6.0 libonig5 libphobos2-ldc-shared-dev libphobos2-ldc-shared82

# Check if dependencies are correctly installed and remove build dependencies
# and artifacts
RUN rm -rf /opt/build-and-install.sh \
           "$HOME/.dub"
    # prevent required shared objects from removal
RUN install_packages \
        libgcc-8-dev libgomp1 libstdc++-8-dev libunwind8
RUN apt-get remove -y \
        build-essential autoconf automake libtool pkg-config \
        git ca-certificates \
        zlib1g-dev libgmp-dev libunwind-dev
    # let dentist check if the dependencies are present
RUN dentist -d
