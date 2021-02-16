#!/usr/bin/env bash

set -e

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cd ${this_dir}

cmd=${1} 

build_version="$(head -n 1 version.txt)"
version=${2:-$build_version}
recreate_volumes=${3:-false}

if [[ -z ${cmd} ]]; then
  echo "command missing" && exit 1
fi

if [[ -z ${version} ]]; then
  echo "version not set" && exit 1
fi

echo "Using volumes:"
data_volume_name=openstreetmap-data; echo ${data_volume_name}
tiles_volume_name=openstreetmap-rendered-tiles; echo ${tiles_volume_name}

if [[ ${recreate_volumes} = true ]]; then  
    echo "Re-creating volumes ..."
    docker volume rm ${data_volume_name}
    docker volume create ${data_volume_name}
    docker volume rm ${tiles_volume_name}
    docker volume create ${tiles_volume_name}
fi

image_name=openstreetmap-custom:${version}

case $cmd in
  import)
    echo "Importing data..."
    docker run --rm \
        -v ${data_volume_name}:/var/lib/postgresql/12/main \
        -e PGPASSWORD=secret \
        ${image_name} \
        import
    echo "DONE"
    ;;

  run)
    echo "Running image..."
    docker run \
      -p 8888:80 \
      -p 5555:5432 \
      -e PGPASSWORD=secret \
      -v ${tiles_volume_name}:/var/lib/mod_tile \
      -v ${data_volume_name}:/var/lib/postgresql/12/main \
      -d ${image_name} \
      run
    echo "OSM server running at 8888 with DB at 5555"
    ;;

  *)
    echo -n "unknown command ${cmd}"
    exit 1
    ;;
esac
