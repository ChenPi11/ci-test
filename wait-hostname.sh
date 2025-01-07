#!/bin/bash

FILE=/opt/homebrew/var/lib/tor/hidden_service/hostname

while [ ! -f "$FILE" ]; do
    echo "Waiting for $FILE ..."
    sleep 3
done

echo =====================================
cat $FILE
echo =====================================

cat $FILE > /tmp/hostname
chmod 7777 /tmp/hostname
