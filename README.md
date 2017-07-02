# docker-nzbhydra

This [Docker](https://www.docker.com) image allows you to run a
[NZBHydra](https://github.com/theotherp/nzbhydra) instance.

## Volumes
The configuration is located at `/nzbhydra/settings.conf`. You can mount
a volume on this file to use a persistent configuration across container
updates.
