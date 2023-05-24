# use

Run directly to print the `gitstats` command help.

```bash
docker run \
    xiaoyao9184/docker-gitstats:latest
```


Map the git source code directory and report output directory 
to the default path of the container without setting any parameters.

```bash
docker run \
    -v ./gitpath:/git-projects/default \
    -v ./outputpath:/output-reports/default \
    xiaoyao9184/docker-gitstats:latest
```


Pass parameters `gitpath` and `outputpath` to the `gitstats` command.

```bash
docker run \
    -v ./gitpath:/git-projects/project1 \
    -v ./outputpath:/output-reports/project1 \
    xiaoyao9184/docker-gitstats:latest \
    /git-projects/project1 /output-reports/project1
```


In addition to using the command line to set parameters,
you can also use environment variables to set parameters. 
By capitalizing all of them and adding the prefix `GITSTATS_CONFIG_`, 
you can set the option of command `gitstats`.

```bash
docker run \
    -v ./gitpath:/git-projects/project1 \
    -v ./outputpath:/output-reports/project1 \
    -e GITSTATS_CONFIG_PROJECT_NAME=project1 \
    xiaoyao9184/docker-gitstats:latest \
    /git-projects/project1 /output-reports/project1
```

Setting two environment variables is equal to setting command line parameters `gitpath` and `outputpath`.

- GITSTATS_PATH_GIT
- GITSTATS_PATH_OUTPUT
