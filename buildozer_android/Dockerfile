# Docker image for running building the APK via buildozer
# Build with:
# docker build --tag=buildozer .
# Run with:
# docker run buildozer /bin/sh -c 'USE_SDK_WRAPPER=True buildozer android debug'
# Or for interactive shell:
# docker run -it --rm buildozer
FROM ubuntu:18.04

ENV USER="user"
ENV HOME_DIR="/home/${USER}"
ENV WORK_DIR="${HOME_DIR}" \
    PATH="${HOME_DIR}/.local/bin:${PATH}"

# get the latest version from https://www.crystax.net/en/download
ENV CRYSTAX_NDK_VERSION="10.3.2"
# we install SDK Tools manually because Buildozer currently only installs
# old Android SDK, that doesn't prove the `sdkmanager` binary
# get the latest version from https://developer.android.com/studio/index.html
ENV ANDROID_SDK_TOOLS_VERSION="3859397"


ENV ANDROID_HOME="${HOME_DIR}/.buildozer"
ENV CRYSTAX_NDK_HOME="${ANDROID_HOME}/crystax-ndk" \
    ANDROID_SDK_HOME="${ANDROID_HOME}/android/platform/android-sdk-20"
ENV ANDROID_NDK_HOME="${ANDROID_SDK_HOME}/ndk-bundle" \
	CRYSTAX_NDK_HOME_V="${CRYSTAX_NDK_HOME}-${CRYSTAX_NDK_VERSION}"
ENV CRYSTAX_NDK_ARCHIVE="crystax-ndk-${CRYSTAX_NDK_VERSION}-linux-x86_64.tar.xz" \
    ANDROID_SDK_TOOLS_ARCHIVE="sdk-tools-linux-${ANDROID_SDK_TOOLS_VERSION}.zip"
ENV CRYSTAX_NDK_DL_URL="https://eu.crystax.net/download/${CRYSTAX_NDK_ARCHIVE}" \
	ANDROID_SDK_TOOLS_DL_URL="https://dl.google.com/android/repository/${ANDROID_SDK_TOOLS_ARCHIVE}"
ENV ANDROID_SDK="${ANDROID_SDK_HOME}" \
	ANDROID_NDK="${CRYSTAX_NDK_HOME}"


# prepare non root env
RUN useradd --create-home --shell /bin/bash ${USER}
WORKDIR ${WORK_DIR}
# when login to the container for debugging
RUN echo "root:root" | chpasswd

# configure locale
RUN apt update -qq > /dev/null && apt install --yes --no-install-recommends \
    locales && \
    locale-gen en_US.UTF-8
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

# install system dependencies
RUN apt update -qq > /dev/null && apt install --yes --no-install-recommends \
    python python-pip python-setuptools python3.6 python3-setuptools libpython3.6-dev \
    git curl wget vim autogen autoconf automake libtool pkg-config libltdl-dev libsdl2-dev \
    libsdl2-ttf-dev libsdl2-image-dev libsdl2-mixer-dev

# build dependencies
# https://buildozer.readthedocs.io/en/latest/installation.html#android-on-ubuntu-18-04-64bit
RUN dpkg --add-architecture i386 &&  apt update -qq && apt install -qq --yes --no-install-recommends \
        build-essential ccache git libncurses5:i386 libstdc++6:i386 libgtk2.0-0:i386 \
        libpangox-1.0-0:i386 libpangoxft-1.0-0:i386 libidn11:i386 python2.7 python2.7-dev \
        openjdk-8-jdk unzip zlib1g-dev zlib1g:i386 libffi-dev

USER ${USER}

# download and install CrystaX NDK
# added `gnutls_handshake` flag to workaround random `gnutls_handshake()` issues
RUN curl --location --progress-bar "${CRYSTAX_NDK_DL_URL}" --output "${CRYSTAX_NDK_ARCHIVE}" --insecure && \
	mkdir -p "${ANDROID_HOME}"
RUN tar -xf "${CRYSTAX_NDK_ARCHIVE}" --directory "${ANDROID_HOME}" \
    --exclude=crystax-ndk-${CRYSTAX_NDK_VERSION}/docs \
    --exclude=crystax-ndk-${CRYSTAX_NDK_VERSION}/samples \
    --exclude=crystax-ndk-${CRYSTAX_NDK_VERSION}/tests \
    --exclude=crystax-ndk-${CRYSTAX_NDK_VERSION}/toolchains/renderscript \
    --exclude=crystax-ndk-${CRYSTAX_NDK_VERSION}/toolchains/x86_64-* \
    --exclude=crystax-ndk-${CRYSTAX_NDK_VERSION}/toolchains/llvm-* \
    --exclude=crystax-ndk-${CRYSTAX_NDK_VERSION}/toolchains/aarch64-* \
    --exclude=crystax-ndk-${CRYSTAX_NDK_VERSION}/toolchains/mips64el-*
RUN ln -sfn "${CRYSTAX_NDK_HOME_V}" "${CRYSTAX_NDK_HOME}"

# download and install Android SDK
RUN curl --location --progress-bar "${ANDROID_SDK_TOOLS_DL_URL}" --output "${ANDROID_SDK_TOOLS_ARCHIVE}" && \
    mkdir --parents "${ANDROID_SDK_HOME}" && \
    unzip -q "${ANDROID_SDK_TOOLS_ARCHIVE}" -d "${ANDROID_SDK_HOME}"

# update Android SDK, install Android API, Build Tools...
RUN mkdir --parents "${ANDROID_SDK_HOME}/.android/" && \
    echo '### User Sources for Android SDK Manager' > "${ANDROID_SDK_HOME}/.android/repositories.cfg"
RUN yes | "${ANDROID_SDK_HOME}/tools/bin/sdkmanager" --licenses
RUN "${ANDROID_SDK_HOME}/tools/bin/sdkmanager" "platforms;android-19"
RUN "${ANDROID_SDK_HOME}/tools/bin/sdkmanager" "build-tools;26.0.2"

# install buildozer and dependencies
RUN pip install Cython==0.25.2 buildozer

WORKDIR ${WORK_DIR}
COPY . ${WORK_DIR}
