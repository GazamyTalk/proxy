#!/bin/bash

/app/apply_env.sh /app/nginx.conf
/app/apply_env.sh /app/initial_nginx.conf

if [ -f "/etc/letsencrypt/options-ssl-nginx.conf" ]
then
    echo "ssl file exist. run normal nginx"
    cp /app/nginx.conf /etc/nginx/nginx.conf
    service nginx start
    certbot renew;
else
    echo "ssl file not exist. run initial nginx"
    cp /app/initial_nginx.conf /etc/nginx/nginx.conf
    service nginx start
    certbot run -i nginx --webroot -w /usr/share/nginx/html -d 139.150.74.9.sslip.io -n --agree-tos --email "${ADMIN_EMAIL}" --dry-run
    cp /app/nginx.conf /etc/nginx/nginx.conf
fi
service nginx stop


service cron start
crontab /etc/cron.d/mycron &
echo "Start NGINX"
nginx -g 'daemon off;'