# Build GCC with latest spack
ARG SPACK_IMAGE="spack/ubuntu-bionic"
ARG SPACK_VERSION="0.14"
FROM ${SPACK_IMAGE}:${SPACK_VERSION}

LABEL maintainer="Wang An <wangan.cs@gmail.com>"

USER root

ARG GCC_VERSION="9.2.0"
ENV GCC_VERSION=${GCC_VERSION}

# install GCC
RUN set -eu; \
      \
      spack install --show-log-on-error -y gcc@${GCC_VERSION}; \
      spack load gcc@${GCC_VERSION}; \
      spack compiler add


# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL="https://github.com/alephpiece/docker-gcc"
LABEL org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name="GCC docker image" \
      org.label-schema.description="An image for GCC" \
      org.label-schema.license="MIT" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vcs-url=${VCS_URL} \
      org.label-schema.schema-version="1.0"


# setup entrypoint
ENTRYPOINT ["/bin/bash"]
CMD ["spack find"]
