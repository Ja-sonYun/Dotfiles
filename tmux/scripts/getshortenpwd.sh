#!/bin/bash
ARG=$1
HOME=$HOME
PWD="${ARG/$HOME/~}"
# PWD=$ARG
OUTPUT='/'
arrPWD=(${PWD//// })
for i in "${arrPWD[@]}"
do
    if [ "$i" = "${arrPWD[${#arrPWD[@]}-1]}" ]; then
        OUTPUT+="$i"
    else
        TEMP=`echo $i | cut -c1-2`
        OUTPUT+="$TEMP"/
    fi
done
OUTPUT="${OUTPUT/\/~\//~/}"
OUTPUT="${OUTPUT/\/~/~}"
echo "$OUTPUT"
