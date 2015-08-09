#!/bin/bash

if [ ! "$(id -u znc)" -eq "$PUID" ]; then usermod -u "$PUID" znc ; fi
if [ ! "$(id -g znc)" -eq "$PGID" ]; then groupmod  -o -g "$PGID" znc ; fi

echo "
-----------------------------------
GID/UID
-----------------------------------
User uid:    $(id -u abc)
User gid:    $(id -g abc)
-----------------------------------
"
