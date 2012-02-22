#!/bin/bash

#./regex_gen.sh <word> <file>

Word=`echo $1 | sed 's/./.*&/g'`

echo $Word >> $2
