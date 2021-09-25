#!/bin/bash

set -e

DOMAIN=$1
DOMAIN_CRT=$2

if [ "$DOMAIN_CRT" == "" ]
then
  DOMAIN_CRT=$DOMAIN;
fi

if [ "$DOMAIN" != "" ]
then
    sudo aws s3 cp s3://brizy-cloud-ssl/certificates/$DOMAIN_CRT /etc/nginx/ssl/$DOMAIN_CRT/ --recursive
    sudo aws s3 cp s3://brizy-cloud-ssl/hosts/$DOMAIN /etc/nginx/sites-available/

    sudo ln -sf /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/$DOMAIN

    sudo service nginx reload

    echo "Done $DOMAIN";
else
    sudo aws s3 cp s3://brizy-cloud-ssl/certificates /etc/nginx/ssl/ --recursive
    sudo aws s3 cp s3://brizy-cloud-ssl/hosts /etc/nginx/sites-available/ --recursive

    for f in /etc/nginx/sites-available/*; do sudo ln -sf "$f" /etc/nginx/sites-enabled/; done

    sudo service nginx reload

    echo 'Done all';
fi
