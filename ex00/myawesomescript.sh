#!/bin/sh

RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
END='\033[0m'

if [ "$#" -ne 1 ]; then
    echo "${ORANGE}USAGE: $0 <bit.ly/url>${END}"
    exit 1
fi

echo "$1" | grep "bit.ly" > /dev/null
if [ $? -ne 0 ]; then
    echo "${RED}ERROR: This is not a bit.ly URL${END}"
    exit 1
fi

RESULT=$(curl -sI "$1" | grep -i "Location" | cut -d' ' -f2)

if [ -z "$RESULT" ]; then
    echo "${RED}ERROR: Cannot resolve the link, is your link correct ? Did you check for typos ?${END}"
    exit 1
fi

echo "${GREEN}$RESULT${END}"