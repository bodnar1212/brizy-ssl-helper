#!/bin/bash

set -e

DOMAIN=$1

if [ "$DOMAIN" != "" ]
then
    sudo rm -f /etc/nginx/sites-available/$DOMAIN
    sudo rm -f /etc/nginx/sites-enabled/$DOMAIN

    sudo service nginx reload

    echo "Done";
fi