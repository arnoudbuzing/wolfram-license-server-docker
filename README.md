# Wolfram License Server for Docker

## Introduction

This runs the Wolfram License Server (also known as MathLM) on Docker.

## Build

To build, run the following command:

```
docker build -t arnoudbuzing/wolfram-license-server .
```

## Run

To run, do the following:

```
docker run -P --volume D:/github/wolfram-license-server-docker/mathpass:/wolfram/mathpass arnoudbuzing/wolfram-license-server
```

1. The `-P` option binds the license server ports (16286 and 16287)
2. The `--volume` makes the `mathpass` file available from the host machine to the Docker image.
3. The `mathpass` file content is provided by Wolfram Research to licensed users.

## Special Notes

On a Windows host you may need to route the traffic as follows (for a client to be able to find the server):

```
route /P add 172.0.0.0 MASK 255.0.0.0 10.0.75.2
```

See: https://github.com/docker/for-win/issues/221
