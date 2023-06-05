FROM nginx:latest

RUN apt-get update
RUN apt-get install -y letsencrypt cron python3-certbot-nginx

RUN mkdir /app
WORKDIR /app

COPY ./run.sh /app/run.sh
COPY ./apply_env.sh /app/apply_env.sh
RUN chmod 744 /app/apply_env.sh

COPY ./nginx.conf /app/nginx.conf
COPY ./initial_nginx.conf /app/initial_nginx.conf

COPY ./cronjob.txt /etc/cron.d/mycron
RUN chmod 0644 /etc/cron.d/mycron

EXPOSE 443
EXPOSE 80

CMD ["/bin/bash", "-c", "/app/run.sh"]