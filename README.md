![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](http://linuxserver.io) team brings you another quality container release featuring auto-update of dependencies on startup, easy user mapping and community support. Be sure to checkout our [forums](http://forum.linuxserver.io) or for real-time support our [IRC](http://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/piwigo

Piwigo is a photo gallery software for the web that comes with powerful features to publish and manage your collection of pictures.
[Piwigo](http://piwigo.org/)

## Usage

```
docker create --name=piwigo -v /etc/localtime:/etc/localtime:ro -v <path to data>:/config -e PGID=<gid> -e PUID=<uid>  -e TZ=<timezone> -p 80:80 linuxserver/piwigo
```

**Parameters**

* `-p 80` - webui port *see note below*
* `-v /etc/localhost` for timesync - *optional*
* `-v /config` - folder to store appdata and config file for piwigo
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for setting timezone information, eg Europe/London
It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it piwigo /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

You must create a user and database for piwigo to use in a mysql/mariadb server. In the setup page for database, use the ip address rather than hostname...

A basic apache configuration file can be found in /config/apache/site-confs , edit the file to enable ssl (port 443 by default), set servername etc.. 
Self-signed keys are generated the first time you run the container and can be found in /config/keys , if needed, you can replace them with your own.

The easiest way to edit the configuration file is to enable local files editor from the plugins page and use it to configure email settings etc....


## Updates

* To update the packages like apache etc `docker restart piwigo`.
* To update piwigo if required, update via the webui
* To monitor the logs of the container in realtime `docker logs -f piwigo`.



## Versions

+ **29.08.2015:** Initial Release.
