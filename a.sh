#!/bin/bash
FILE=/opt/homebrew/var/lib/tor/hidden_service/hostname
while [ ! -f "$FILE" ]; do
    echo "Waiting for $FILE ..."
    sleep 5
done

echo =====================================
echo =====================================
echo =====================================
echo =====================================
echo =====================================
echo Our HOSTNAME:
cat $FILE
echo =====================================
echo =====================================
echo =====================================
echo =====================================
echo =====================================

FILE=/Users/runner/.config/code-server/config.yaml
while [ ! -f "$FILE" ]; do
    echo "Waiting for $FILE ..."
    sleep 5
done
echo =====================================
echo =====================================
echo =====================================
echo =====================================
echo =====================================
echo Our CONFIG:
cat $FILE
echo =====================================
echo =====================================
echo =====================================
echo =====================================
echo =====================================

#brew services logs tor > /tmp/service1.log &
#brew services logs code-server > /tmp/service2.log &
#tail -f /tmp/service1.log /tmp/service2.log | tee /dev/stdout
while true
do
ls /opt/homebrew/var/log/
sleep 10
done
