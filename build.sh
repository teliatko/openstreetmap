#!/usr/bin/env bash

set -e

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cd ${this_dir}

version=$1

if [[ -z ${version} ]]; then
  echo "version not set" && exit 1
fi

image_name=openstreetmap-custom:${version}
echo ${version} > version.txt
echo "Preparing image: ${image_name}"

echo "Building image..."
docker build . -f Dockerfile -t ${image_name}

echo "DONE"
