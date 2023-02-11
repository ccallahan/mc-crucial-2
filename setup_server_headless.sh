#!/bin/bash

mkdir mods
cat mods.csv | sed -r 's/\r//g' | sed -r 's/(.+),(.+)/-c "wget -c \1 -O \2"/g' | xargs -n2 bash

java -jar forge-installer.jar --installServer
