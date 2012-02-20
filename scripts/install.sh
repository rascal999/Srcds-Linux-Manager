#!/bin/bash

#wget http://steampowered.com/download/hldsupdatetool.bin
chmod +x hldsupdatetool.bin
./hldsupdatetool.bin
./steam
./steam -command update -game tf -dir .
./steam -command update -game garrysmod -dir .
echo "Done."
