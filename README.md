# This is an example project of OSM using Humanitarian Layer (only style)

It is based on https://github.com/hotosm/HDM-CartoCSS and modified.
The Docker image is based on https://github.com/Overv/openstreetmap-tile-server.git.

## Prepare

```bash
$ ./prepare.sh
```

- Downloads SRTM Data for whole Europe into `carto-style/DEM/data`
- Prepare hillshades and coutours from the data
- Downloads polygons from OSM into `carto-style/DEM/data`
- Downloads maps for Luxembourg info `map-data`

## Build

```bash
$ ./build.sh <version>
```

- Builds Docker image
- Writes version to `version.txt`

## Import 

```bash
$ ./run.sh import [version] [recreate-volumes]
```

- Imports the data into Docker volume named `openstreetmap-data`.
- Version can be set explicity or `version.txt` is read
- To re-create volumes explicit version must be specified.
- Re-creating of volumes removes and creates following Docker volumes anew:
  - `openstreetmap-data` - for Postgres data
  - `openstreetmap-rendered-tiles` - for generated tiles

## Run

```bash
$ ./run.sh run [version]
```

- Runs the server at 8888 and exposes Postgres DB at 5555
- It uses both volumes `openstreetmap-data` and `openstreetmap-rendered-tiles`
- Either you will create the volumes manually or use re-create flag by `import` command.


// TODO: Troubleshooting
// - Using Tilemill
// - Using original image to check the styling 
