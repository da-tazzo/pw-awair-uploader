FROM accetto/ubuntu-vnc-xfce-chromium-g3

ARG ARG_AU_COMPILE_DIR
ARG ARG_AU_REPO
ARG ARG_NODEJS_VERSION
ARG ARG_NODEJS_DISTRO

ENV AU_COMPILE_DIR=${ARG_AU_COMPILE_DIR:-/home/headless/awair-dev} \
    AU_REPO=${ARG_AU_REPO:-https://github.com/Sheherezadhe/awair-uploader.git}

USER root

RUN apt update
RUN \
#    --mount=type=cache,target=/var/cache/apt,from=stage_cache,source=/var/cache/apt \
#    --mount=type=cache,target=/var/lib/apt,from=stage_cache,source=/var/lib/apt \
    DEBIAN_FRONTEND=noninteractive apt upgrade
RUN \
#    --mount=type=cache,target=/var/cache/apt,from=stage_cache,source=/var/cache/apt \
#    --mount=type=cache,target=/var/lib/apt,from=stage_cache,source=/var/lib/apt \
    DEBIAN_FRONTEND=noninteractive apt install -y xz-utils git libgl1-mesa-glx

# install nodejs
RUN NODEJS_PATH=/usr/local \
    NODEJS_VERSION=${ARG_NODEJS_VERSION:-v16.14.2} \
    NODEJS_DISTRO=${ARG_NODEJS_DISTRO:-linux-x64} \
    && wget -qO- https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-${NODEJS_DISTRO}.tar.xz \
        | tar --strip-components 1 -xJv -C ${NODEJS_PATH}

ADD start-awair-uploader.sh /home/headless
RUN chmod 755 /home/headless/start-awair-uploader.sh \
 && chown headless /home/headless/start-awair-uploader.sh

USER headless

RUN mkdir -p "${AU_COMPILE_DIR}" \
 && cd "${AU_COMPILE_DIR}" \
 && git clone ${AU_REPO} \
 && cd `echo "${AU_REPO}" | sed s/"^.*\/\([^\/]*\).git"/"\1"/g` \
 && npm install

USER root

RUN chown root "${AU_COMPILE_DIR}"/`echo "${AU_REPO}" | sed s/"^.*\/\([^\/]*\).git"/"\1"/g`/node_modules/electron/dist/chrome-sandbox \
 && chmod 4755 "${AU_COMPILE_DIR}"/`echo "${AU_REPO}" | sed s/"^.*\/\([^\/]*\).git"/"\1"/g`/node_modules/electron/dist/chrome-sandbox

USER headless

RUN cd "${AU_COMPILE_DIR}"/`echo "${AU_REPO}" | sed s/"^.*\/\([^\/]*\).git"/"\1"/g` \
 && npm run package \
 && ln -s "${AU_COMPILE_DIR}"/`echo "${AU_REPO}" | sed s/"^.*\/\([^\/]*\).git"/"\1"/g`/out/`ls -1tr out/ | tail -n 1` /home/headless/awair-uploader
