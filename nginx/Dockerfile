FROM nginx:alpine

RUN apk add --no-cache curl

COPY conf/default.conf.template /etc/nginx/conf.d/default.conf.template

EXPOSE 80

CMD ["/bin/sh", "-c", "envsubst '${FRONTEND_URL} ${API_GATEWAY_URL} ${NGINX_HOST_PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]
