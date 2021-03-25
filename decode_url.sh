#!/bin/bash
printf $(awk '/\["data","dash","'$1'",0,"backupUrl",0\]/{print $2}' $2)"\n" | tr -d '"'