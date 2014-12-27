#!/bin/bash

# see https://github.com/OpenRA/OpenRA/wiki/Dedicated
#
Name="${NAME:-"Dedicated-Server"}"
Mod=${MOD:-"ra"} #
LockBots=${LOCK_BOTS:-"False"}
Ban=${BAN:-""}
Dedicated="True"
DedicatedLoop="True" # A new instance is spawned once previous game is finished
ListenPort=1234
ExternalPort=1234
AdvertiseOnline=${ADVERTISE_ONLINE:-"False"}

MOTD="${MOTD:-"welcome to a Docker based OpenRA server"}"
echo $MOTD > /home/openra/.openra/motd.txt

# if no maps volume is mounted, sync the latest maps from the community rsync service
[ "$(ls -A /home/openra/.openra/maps/)" ] && echo "will use existing maps" || rsync --delete -avp rsync://resource.openra.net/maps/ /home/openra/.openra/maps/

mono --debug /usr/lib/openra/OpenRA.Game.exe Game.Mod=$Mod Server.Dedicated=$Dedicated Server.DedicatedLoop=$DedicatedLoop \
Server.Name="$Name" Server.ListenPort=$ListenPort Server.ExternalPort=$ExternalPort \
Server.LockBots=$LockBots \
Server.Ban="$Ban" \
Server.AdvertiseOnline=$AdvertiseOnline