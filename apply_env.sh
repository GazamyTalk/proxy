#!/bin/bash

if [ -n "$DOMAIN_NAME" ]; then
    echo "DOMAIN_NAME: ${DOMAIN_NAME}";
    sed -i "s@ENV_DOMAIN_NAME@${DOMAIN_NAME}@g" $1;
else
    echo "Require DOMAIN_NAME environment variable" > /dev/stderr;
    exit 1;
fi