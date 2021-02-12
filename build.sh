docker build . -f Dockerfile -t openstreetmap-custom:latest

docker volume create openstreetmap-data-custom

docker run \
    -v openstreetmap-data-custom:/var/lib/postgresql/12/main \
    openstreetmap-custom:latest \
    import

docker run \
    -p 8888:80 \
    -v openstreetmap-data-custom:/var/lib/postgresql/12/main \
    -d openstreetmap-custom:latest \
    run

-- 

docker volume rm openstreetmap-data-custom