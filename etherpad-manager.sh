#!/bin/bash

min_stamp=$(date -d "-7 days" +%s)

count=0

for p in $(curl -s "http://etherpad-svc/api/1.2.1/listAllPads?apikey=$ETHERPAD_API_KEY" | jq .data.padIDs[] | xargs echo); do 
	last_updated=$(curl -s "http://etherpad-svc/api/1/getLastEdited?apikey=${ETHERPAD_API_KEY}&padID=$p" | jq '.data.lastEdited')
	((last_stamp=last_updated/1000))
	if [[ $last_stamp -lt $min_stamp ]]; then
		echo $p is old and should be deleted
		((count++))
	fi
done

echo "Identified $count pads for removal"
