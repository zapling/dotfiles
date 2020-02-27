#!/bin/sh

ABC_LIST="abcdefghijklmnopqrstuvwxyz"
CHAR=$1

if [ -z "$CHAR" ]
then
	echo $ABC_LIST
	exit 0
fi

i=1;
while [ $i -le ${#ABC_LIST} ]; do
	CURRENT_CHAR=$(echo $ABC_LIST | awk -v i="$i" '{printf substr($0, i, 1)}')

	if [ "$CURRENT_CHAR" = "$CHAR" ]
	then
		tput setaf 1
		printf "$CURRENT_CHAR"
		tput sgr0
	else
		printf "$CURRENT_CHAR"
	fi

	i=$((i+1));
done;

echo ""
