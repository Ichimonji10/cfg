FROM nginx:alpine
LABEL maintainer="jerebear@protonmail.com"
COPY ["-usr-share-nginx-", "/usr/share/nginx/"]
COPY ["-etc-nginx-conf.d-", "/etc/nginx/conf.d/"]
COPY ["ssl/*.chained.crt", "/etc/nginx/ssl/"]
