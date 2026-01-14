#!/bin/bash

WORKDIR="{$WORKDIR:-/srv/services}"

function update(){
	echo -e "UPDATING $1 ...:\n"
	docker compose -f "$1" pull && docker compose -f "$1" up -d
	echo -e "=================\n"
}

files=$(find $WORKDIR -type f -name "*compose.y*ml")

for file in files
do
	update $file
done

docker image prune -f

bash /usr/local/bin/update-filebrowser.sh
