[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: http://piwigo.org/
[hub]: https://hub.docker.com/r/linuxserver/piwigo/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/piwigo
[![](https://images.microbadger.com/badges/version/linuxserver/piwigo.svg)](https://microbadger.com/images/linuxserver/piwigo "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/piwigo.svg)](https://microbadger.com/images/linuxserver/piwigo "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/piwigo.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/piwigo.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-piwigo)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-piwigo/)

Piwigo is a photo gallery software for the web that comes with powerful features to publish and manage your collection of pictures.

[![piwigo](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/piwigo-banner.png)][appurl]

## Usage

```
docker create \
--name=piwigo \
-v /etc/localtime:/etc/localtime:ro \
-v <path to data>:/config \
-e PGID=<gid> -e PUID=<uid>  \
-e TZ=<timezone> \
-p 80:80 \
linuxserver/piwigo
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 80` - webui port *see note below*
* `-v /etc/localtime` for timesync - *optional*
* `-v /config` - folder to store appdata and config file for piwigo
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for setting timezone information, eg Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it piwigo /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

You must create a user and database for piwigo to use in a mysql/mariadb server. In the setup page for database, use the ip address rather than hostname....

A basic nginx configuration file can be found in /config/nginx/site-confs , edit the file to enable ssl (port 443 by default), set servername etc..
Self-signed keys are generated the first time you run the container and can be found in /config/keys , if needed, you can replace them with your own.

The easiest way to edit the configuration file is to enable local files editor from the plugins page and use it to configure email settings etc....


## Info

* To update piwigo if required, update via the webui
* To monitor the logs of the container in realtime `docker logs -f piwigo`.

* container version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' piwigo`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/piwigo`

## Versions

+ **28.01.19:** Rebase to alpine linux 3.8 , add pipeline logic and multi arch.
+ **25.01.18:** Rebase to alpine linux 3.7.
+ **25.05.17:** Rebase to alpine linux 3.6.
+ **03.05.17:** Use repo pinning to better solve dependencies, use repo version of php7-imagick.
+ **20.04.17:** Add php7-exif package, thanks iiska
+ **23.02.17:** Rebase to alpine linux 3.5 and nginx.
+ **14.10.16:** Add version layer information.
+ **10.09.16:** Add layer badges to README.
+ **29.08.15:** Initial Release.
