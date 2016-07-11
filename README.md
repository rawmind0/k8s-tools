kube-tools
=============

A base image to expose tools to services. It's based in [rawmind/alpine-tools][alpine-tools], adding confd and monit scripts to the image.

##Build

```
docker build -t rawmind/kube-tools:<version> .
```

## Tools volume

This images creates a volume /opt/tools and permits share tools with the services, avoiding coupling service with configuration.

That volume has the following structure:

```
|- /opt/tools
|-|- confd 	# Confd directory
|-|-|- etc
|-|-|-|- templates
|-|-|-|- conf.d
|-|-|- bin/service-conf.sh          # Confd script to start stop or restart confd with rancher config
|-|- monit/conf.d/monit-conf.cfg  	# Confd start script for monit
```


## Versions

- `0.3.4` [(Dockerfile)](https://github.com/rawmind0/kube-tools/blob/0.3.4/Dockerfile)

## Usage

To use this image include `FROM rawmind/kube-tools` at the top of your `Dockerfile`, add templates and conf.d files from your service.

Starting from `rawmind/kube-tools` provides you with the ability to easily get dinamic configuration using confd. confd will also keep running checking for config changes, restarting your service.

This image has to be started once as a sidekick of your service (based in alpine-monit), exporting a /opt/tools volume to it. It adds monit conf.d to start confd with a default parameters, that you can overwrite with environment variables.

## Default parameters

These are the default parameters to run confd. You could overwrite these values, setting environment variables.

- CONF_NAME=confd
- CONF_HOME=${CONF_HOME:-"/opt/tools/confd"}
- CONF_LOG=${CONF_LOG:-"${CONF_HOME}/log/confd.log"}
- CONF_BIN=${CONF_BIN:-"${CONF_HOME}/bin/confd"}
- CONF_BACKEND=${CONF_BACKEND:-"etcd"}
- CONF_PREFIX=${CONF_PREFIX:-"/registry"}
- CONF_NODE=${CONF_NODE:-"etcd.kubernetes.rancher.internal:2379"}
- CONF_INTERVAL=${CONF_INTERVAL:-"watch"}
- CONF_PARAMS=${CONF_PARAMS:-"-confdir /opt/tools/confd/etc -backend ${CONF_BACKEND} -prefix ${CONF_PREFIX} -node ${CONF_NODE}"}
- CONF_INTERVAL="${CONF_BIN} ${CONF_INTERVAL} ${CONF_PARAMS}"


## Examples

An example of using this image can be found in the [rawmind/kube-traefik][kube-traefik].

[kube-traefik]: https://github.com/rawmind0/kube-traefik
[alpine-tools]: https://github.com/rawmind0/alpine-tools

