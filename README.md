# arbordock

Arbor phylogenetics methods exposed through Docker.

## Usage through Docker

List the methods available through Docker:
```
docker run kitware/arbordock
```

Run a method through Docker:
```
docker run <docker_options> kitware/arbordock <arg1> ...
```

In order to send data files to Docker, mount a volume and use the mounted
volume prefix for the input and output paths. For example, if `anolis.phy`
and `anolis.csv` are in your current directory (these are available in
the Git repository), the following will produce `svl-model.csv` in the current
directory:
```
docker run -v $PWD:/data kitware/arbordock /data/anolis.phy /data/anolis.csv lambda SVL /data/svl-model.csv
```

To build the Docker image locally:
```
git clone https://github.com/arborworkflows/arbordock.git
cd arbordock
docker build -t arbordock .
```

Now use `arbordock` instead of `kitware/arbordock` in the commands
above to use your local version.

## Usage through Girder

* Install Girder.
* Enable the "Item tasks" plugin.
* Start a `girder_worker` Celery worker and point it and the Worker plugin settings to use the same task queue.
* From any folder you have write access to (you must be admin), select
  "Add tasks" from the actions menu.
* Enter "kitware/arbordock" as the image name and click Run. Wait for the task to complete, which could take a few minutes.
* Upload `anolis.phy` (tree) and `anolis.csv` (character matrix) into Girder.
* Go to "Phylogenetic signal" from the Tasks page in the left sidebar.
* Fill in the task parameters (enter a column name from the character matrix such as "SVL" for the column parameter) and click Run.
* Click "View output item" under "Outputs" on the task page to see the resulting model fit parameters.
