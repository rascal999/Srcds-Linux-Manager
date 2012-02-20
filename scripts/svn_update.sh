#!/bin/bash

Addons_directory="/home/gmod/srcds/orangebox/garrysmod/addons/"

svn update "$Addons_directory/Adv Duplicator"
svn update "$Addons_directory/wire"
svn update "$Addons_directory/evolvemod"
svn update "$Addons_directory/ulib"
svn update "$Addons_directory/ulx"
svn update "$Addons_directory/phoenix-storms"

#Individual servers
/home/gmod/srcds/scripts/update.sh construct server_construct.cfg
/home/gmod/srcds/scripts/update.sh build server_build.cfg
