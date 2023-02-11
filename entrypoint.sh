#!/bin/bash

neofetch --config /etc/neo.conf

if [[ -f /minecraft/.DO_NOT_DELETE ]] 
then
  /usr/lib/jvm/jre-1.8.0/bin/java -jar /minecraft/forge-1.16.5-36.2.33.jar nogui
else
  echo "Initializing Container, Please Wait" 
  cp -vR /app/* /minecraft/
  touch /minecraft/.DO_NOT_DELETE
  cd /minecraft/
  /usr/lib/jvm/jre-1.8.0/bin/java -jar forge-1.16.5-36.2.33.jar nogui
fi
