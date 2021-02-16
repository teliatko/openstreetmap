#!/usr/bin/env bash

set -e

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cd ${this_dir}/carto-style/DEM

./fetch.sh 28,01,45,06
./hillshade.sh
./merge_contour.sh
wget https://osmdata.openstreetmap.de/download/simplified-land-polygons-complete-3857.zip
unzip https://osmdata.openstreetmap.de/download/simplified-land-polygons-complete-3857.zip
wget https://osmdata.openstreetmap.de/download/land-polygons-split-3857.zip
uzip https://osmdata.openstreetmap.de/download/land-polygons-split-3857.zip

cd ${this_dir}/map-data

wget http://download.openstreetmap.fr/extracts/europe/luxembourg-latest.osm.pbf
wget http://download.openstreetmap.fr/polygons/europe/luxembourg.poly

echo "DONE"