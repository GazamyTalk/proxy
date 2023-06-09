#!/bin/bash

/app/apply_env.sh /app/nginx.conf
/app/apply_env.sh /app/initial_nginx.conf

echo "DOMAIN NAME: ${DOMAIN_NAME}"
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
    certbot run -i nginx --webroot -w /usr/share/nginx/html -d "${DOMAIN_NAME}" -n --agree-tos --email "${ADMIN_EMAIL}"
    cp /app/nginx.conf /etc/nginx/nginx.conf
fi
service nginx stop


service cron start
crontab /etc/cron.d/mycron &
echo "Start NGINX"
nginx -g 'daemon off;'