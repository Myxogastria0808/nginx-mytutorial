FROM nginx:alpine AS runtime
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./src /usr/share/nginx/html
EXPOSE 80
