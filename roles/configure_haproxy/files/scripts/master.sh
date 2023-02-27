#!/bin/bash
# {{ ansible_managed }}
SERVICE="haproxy"
STATUS="$(systemctl is-active $SERVICE.service)"
if [ "${STATUS}" = "active" ]; then
    echo "Service is running"

else
    echo "Service ${SERVICE}  is not running"
    n=0
    while [ $n -lt 10 ]
    do
        echo $n
        STATUS="$(systemctl is-active ${SERVICE}.service)"
        if [ "${STATUS}" = "active" ]; then
            echo "foi!"
            exit 0
        else
            echo "restarting ${SERVICE}"
            service ${SERVICE} restart
            sleep 2
        fi
        n=$((n+1))
    done
fi