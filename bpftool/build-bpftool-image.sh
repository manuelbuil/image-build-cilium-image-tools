#!/bin/bash

set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

dir=$(dirname "${0}")
BUILD_META=$1
TAG=$2
ARCH=$3
ORG=$4

git clone https://github.com/cilium/image-tools.git $dir/image-tools

pushd $dir/image-tools/images/bpftool/

git checkout ${TAG%"${BUILD_META}"}
git apply ../../../patches/*

docker build \
  --pull \
  --tag ${ORG}/hardened-cilium-bpftool:${TAG} \
  --tag ${ORG}/hardened-cilium-bpftool:${TAG}-${ARCH} \
.
