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
volume prefix for the input and output paths. For example, if `myinput.csv`
is in your current directory, the following will produce `myoutput.csv` in
the current directory:
```
docker run -v $PWD:/data kitware/arbordock <arg1> ...
```

Build the Docker image:
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
* Enter "kitware/arbordock" as the image name and click Run.
* When that task completes, navigate to a created task item and select
  "Run task" from the actions menu.
* Fill in the task parameters and click Run.
