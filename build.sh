export volume_name=openstreetmap-data-custom-original; echo ${volume_name}
export image_name=openstreetmap-custom:v0.0-original; echo ${image_name}

docker build . -f Dockerfile -t ${image_name}

# docker volume rm ${volume_name}
docker volume create ${volume_name}

docker run --rm \
    -v ${volume_name}:/var/lib/postgresql/12/main \
    ${image_name} \
    import

docker run \
    -p 8888:80 \
    -v ${volume_name}:/var/lib/postgresql/12/main \
    -d ${image_name} \
    run

-- 

