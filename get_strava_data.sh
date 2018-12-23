#!/bin/env bash

TOKEN=token
CURRENT_DATE=$(date +%Y%m%d)

while true; do
    TARGET_DATE=$CURRENT_DATE
    CURRENT_DATE=$(date -d "$CURRENT_DATE - 3 months" +%Y%m%d)

    echo "Exporting $TARGET_DATE to ${CURRENT_DATE}.."
    TARGET_EPOCH=$(date -d $TARGET_DATE +%s)
    CURRENT_EPOCH=$(date -d $CURRENT_DATE +%s)

    curl -G https://www.strava.com/api/v3/athlete/activities \
        -d access_token=$TOKEN  \
        -d before=$TARGET_EPOCH \
        -d after=$CURRENT_EPOCH \
        -d per_page=200 > "${TARGET_DATE}_${CURRENT_DATE}.json"
    sleep 10
done
