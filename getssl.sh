#!/bin/bash

set -e

DOMAIN=$1

if [ "$DOMAIN" != "" ]
then
    sudo aws s3 cp s3://brizy-cloud-ssl/hosts/$DOMAIN /etc/nginx/sites-available/
    sudo aws s3 cp s3://brizy-cloud-ssl/certificates/$DOMAIN /etc/nginx/ssl/$DOMAIN/ --recursive

    sudo ln -sf /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/$DOMAIN

    echo "Done $DOMAIN";
else
    sudo aws s3 cp s3://brizy-cloud-ssl/hosts /etc/nginx/sites-available/ --recursive
    sudo aws s3 cp s3://brizy-cloud-ssl/certificates /etc/nginx/ssl/ --recursive

    for f in /etc/nginx/sites-available/*; do sudo ln -sf "$f" /etc/nginx/sites-enabled/; done

    echo 'Done all';
fi

sudo service nginx reload
