#!/bin/bash -x
#	./app/bin/remove-config.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -n "$debug"	|| exit 100					;
#########################################################################
folders=" configs secrets " 						;
#########################################################################
for folder in $folders 							;
do 									\
  rm --recursive --force --verbose /run/$folder 			;
done 									;
#########################################################################
