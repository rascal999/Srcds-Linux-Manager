#!/bin/bash

Addons_directory="/home/gmod/srcds/orangebox/garrysmod/addons/"

#Define which repos you wish to update.
svn update "$Addons_directory/Adv Duplicator"
svn update "$Addons_directory/wire"
svn update "$Addons_directory/evolvemod"
svn update "$Addons_directory/ulib"
svn update "$Addons_directory/ulx"
svn update "$Addons_directory/phoenix-storms"

#Individual servers to restart
/home/gmod/srcds/scripts/restart.sh construct server_construct.cfg 27015
/home/gmod/srcds/scripts/restart.sh construct_build server_construct_build.cfg 27016
/home/gmod/srcds/scripts/restart.sh flatgrass server_flatgrass.cfg 27017
/home/gmod/srcds/scripts/restart.sh flatgrass_build server_flatgrass_build.cfg 27018
