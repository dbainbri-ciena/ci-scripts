#!/bin/bash
VERSION=${VERSION:-$(cat VERSION)}
MAJOR=$(echo $VERSION | cut -d. -f1)
MINOR=$(echo $VERSION | cut -d. -f2)
PATCH=$(echo $VERSION | cut -d. -f3)
NOTE=

if [[ $PATCH =~ [0-9]+-.* ]]; then
    NOTE=$(echo $PATCH | cut -d- -f2)
    PATCH=$(echo $PATCH | cut -d- -f1)
fi

CHECK_VERSION=$MAJOR.$MINOR.$PATCH

LARGEST=$(git tag -l | sort -V -r | head -1)
GOOD=$(echo -e "$CHECK_VERSION\n$LARGEST" | sort -V -r | head -1)
if [[ $GOOD == $LARGEST ]]; then
    echo "New version, '$VERSION', is not greater than largest existing version, '$LARGEST'"
    exit 2
fi
echo "New version, '$VERSION', is valid"
