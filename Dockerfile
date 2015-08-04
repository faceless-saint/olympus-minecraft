FROM hivemined/forge:10.13.2.1291
MAINTAINER "Ryan Clarke"

COPY ["minecraft", "/opt/minecraft/bin/"]

VOLUME ["/opt/minecraft/bin"]
