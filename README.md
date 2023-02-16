
# Personal C4 Models made with Structurizr Lite
> Make sure [Docker](https://docs.docker.com/get-docker/) and [Java](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-do-I-install-Java-on-Windows) are installed on your system before trying to install and run this program.
To install (build from source) and run:
```sh
git clone https://github.com/dainank/c4-models-structurizr-lite.git structurizr-lite
git clone https://github.com/structurizr/ui.git structurizr-ui
cd structurizr-lite
./ui.sh
./gradlew build
docker run -it --rm -p 8080:8080 -v PATH:/usr/local/structurizr structurizr/lite
```
Now browse to to view diagrams: http://localhost:8080/workspace/diagrams

Note that `PATH` refers to the location of the directory containing the `workspace.dsl` file. In my case, this was:

 `docker run -it --rm -p 8080:8080 -v D:/Code/c4-models-structurizr-lite/data:/usr/local/structurizr structurizr/lite`

Below follows information regarding the Structurizr program itself.

![Structurizr](https://static.structurizr.com/img/structurizr-banner.png)

# Structurizr Lite

This version of Structurizr allows you to view/edit diagrams, view documentation, and view architecture decision records defined in a single DSL or JSON workspace.
Structurizr Lite can be used standalone for workspace viewing/authoring, or in conjunction with the cloud service/on-premises installation as an authoring/testing/staging environment.

Structurizr Lite will look for a `workspace.dsl` and `workspace.json` file in a given directory, in that order, and use the file it finds first.
If you change this file (e.g. via your text editor or one of the Structurizr client libraries), you can refresh your web browser to immediately see the changes.

- [Getting started](https://structurizr.com/share/76352/documentation#getting-started)
- [Documentation](https://structurizr.com/share/76352/documentation) ([source](docs))
- [Issue tracker](https://github.com/structurizr/lite/issues)

## Opening C4 Models
`docker run -it --rm -p 8080:8080 -v D:/Code/c4-models-structurizr-lite/data:/usr/local/structurizr structurizr/lite`

## Building from source

- Note 1: The HTML, JS, CSS, JSP, etc files are in a separate [structurizr/ui](https://github.com/structurizr/ui) repo because they are shared with the on-premises installation and cloud service.
- Note 2: Building and running from source has only been tested with Java 17.

To build from source:

```
git clone https://github.com/structurizr/lite.git structurizr-lite
git clone https://github.com/structurizr/ui.git structurizr-ui
cd structurizr-lite
./ui.sh
./gradlew build
```

And to run Structurizr Lite (this has only been tested with Java 17):

```
java -jar build/libs/structurizr-lite.war /path/to/workspace
```

(replace `/path/to/workspace` with the path to the folder where your `workspace.dsl` file is)